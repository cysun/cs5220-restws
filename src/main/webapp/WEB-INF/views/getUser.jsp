<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/xml; UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<user>
  <id>${user.id}</id>
  <firstName>${user.firstName}</firstName>
  <lastName>${user.lastName}</lastName>
  <email>${user.email}</email>
</user>
