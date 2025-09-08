<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Second Hand Bazar</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Bootstrap and your existing assets -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${cp}/asset/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${cp}/asset/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="${cp}/asset/css/nouislider.min.css">
<link rel="stylesheet" type="text/css" href="${cp}/asset/css/slick.css">
<link rel="stylesheet" type="text/css" href="${cp}/asset/css/slick-theme.css">
<link rel="stylesheet" type="text/css" href="${cp}/asset/css/style.css">
<link rel="stylesheet" type="text/css" href="${cp}/css/home.css">

<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700;800&display=swap" rel="stylesheet">


</head>

<body>
<%@ include file="navbar.jsp" %>

<div class="container">
  <!-- HERO -->
  <div class="hero">
    <h3>Welcome, <c:out value="${user.name}"/></h3>
    <p>Here are some recommendations for you.</p>
    <div class="chips">
      <span class="chip"><i class="fa fa-fire"></i> Priority: Category</span>
      <span class="chip"><i class="fa fa-file-text-o"></i> Description Match</span>
      <span class="chip"><i class="fa fa-user-o"></i> Seller Fallback</span>
    </div>
  </div>

  <!-- INFO STATE -->
  <c:if test="${not empty noOrdersMessage}">
    <div class="empty-state mb-4">
      <c:out value="${noOrdersMessage}"/>
    </div>
  </c:if>


  <!-- 1) Naive Bayes FIRST -->
  <h4 class="section-title">
    Recommended (Naive Bayes)
    <span class="badge rounded-pill">Model A</span>
  </h4>

  <c:choose>
    <c:when test="${empty naive}">
      <div class="empty-state mb-4">No recommendations available from Naive Bayes.
      Order some products first</div>
    </c:when>
    <c:otherwise>
      <div class="grid mb-4">
        <c:forEach var="item" items="${naive}">
          <div class="card reco-card">
            <!-- Product image -->
            <div class="reco-media">
              <img src="${pageContext.request.contextPath}/product_image/${item.imageName}"
     alt="Product image for ${item.productId}"
     onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/asset/img/placeholder.png';"
     class="reco-media-img" />
            </div>

            <div class="card-body">
              <div class="d-flex justify-content-between align-items-center mb-2">
                <span class="owner">
                  <i class="fa fa-user-circle-o"></i>
                  <c:out value="${item.ownerName}"/>
                </span>
               <!--  <span class="score-chip">
                  <span class="dot"></span>
                  Score: <fmt:formatNumber value="${item.score}" minFractionDigits="2" maxFractionDigits="4"/>
                </span>  -->
              </div>

              <div class="mb-2">
                <span class="category-badge">
                  <i class="fa fa-tag"></i>
                  <c:out value="${item.category}"/>
                </span>
              </div>
              <p class="description mb-3"><c:out value="${item.productName}"/></p>

              <p class="description mb-3"><c:out value="${item.description}"/></p>

            <!--   <div class="score-bar mb-3">
                <c:set var="scorePct" value="${item.score * 100}"/>
                <div class="score-fill" style="width: <fmt:formatNumber value='${scorePct}' maxFractionDigits='0'/>%;"></div>
              </div>  -->

              <div class="d-flex align-items-center justify-content-between card-actions">
                <c:url var="prodUrl" value="/product/details/${item.productId}"/>
                <a class="view-link" href="${cp}/user/product/details/${item.productId}"
>View product <i class="fa fa-long-arrow-right"></i></a>

                
              </div>
            </div>
          </div>
        </c:forEach>
      </div>
    </c:otherwise>
  </c:choose>

  <div class="section-divider"></div>

  <!-- 2) THEN Logistic Regression -->
  <h4 class="section-title">
    Recommended (Logistic Regression)
    <span class="badge rounded-pill">Model B</span>
  </h4>

  <c:choose>
    <c:when test="${empty logistic}">
      <div class="empty-state mb-4">No recommendations available from Logistic Regression.</div>
    </c:when>
    <c:otherwise>
      <div class="grid mb-4">
        <c:forEach var="item" items="${logistic}">
          <div class="card reco-card">
            <div class="reco-media">
              <img src="${pageContext.request.contextPath}/product_image/${item.imageName}"
     alt="Product image for ${item.productId}"
     onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/asset/img/placeholder.png';"
     class="reco-media-img" />
            </div>

            <div class="card-body">
              <div class="d-flex justify-content-between align-items-center mb-2">
                <span class="owner">
                  <i class="fa fa-user-circle-o"></i>
                  <c:out value="${item.ownerName}"/>
                </span>
               
              </div>

              <div class="mb-2">
                <span class="category-badge">
                  <i class="fa fa-tag"></i>
                  <c:out value="${item.category}"/>
                </span>
              </div>

              <p class="description mb-3"><c:out value="${item.description}"/></p>

              

              <div class="d-flex align-items-center justify-content-between card-actions">
                <c:url var="prodUrl" value="/product/details/${item.productId}"/>
                <a class="view-link" href="${cp}/user/product/details/${item.productId}"
>View product <i class="fa fa-long-arrow-right"></i></a>

                
              </div>
            </div>
          </div>
        </c:forEach>
      </div>
    </c:otherwise>
  </c:choose>

  <div class="footer-gap"></div>
</div>

<%@include file="body.jsp" %>
<%@include file="footer.jsp" %>

<!-- JS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${cp}/asset/js/slick.min.js"></script>
<script src="${cp}/asset/js/nouislider.min.js"></script>
<script src="${cp}/asset/js/jquery.zoom.min.js"></script>
<script src="${cp}/asset/js/main.js"></script>
</body>
</html>