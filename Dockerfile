# Triển khai file WAR đã build sẵn lên Tomcat 10
FROM tomcat:10.1-jdk17

# Xóa các app mặc định của Tomcat cho sạch sẽ
RUN rm -rf /usr/local/tomcat/webapps/*

# Tắt cổng shutdown (8005) của Tomcat để tránh cảnh báo từ Health Check của Render
RUN sed -i 's/port="8005" shutdown="SHUTDOWN"/port="-1" shutdown="SHUTDOWN"/g' /usr/local/tomcat/conf/server.xml

# Copy trực tiếp file WAR từ máy tính vào Docker
# (Không build bằng Ant trên cloud nữa vì lỗi thiếu thư viện NetBeans)
COPY dist/DEMO_duan.war /usr/local/tomcat/webapps/ROOT.war

# Mở cổng 8080
EXPOSE 8080

# Chạy Tomcat
CMD ["catalina.sh", "run"]
