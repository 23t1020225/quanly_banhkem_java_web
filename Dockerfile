# Triển khai file WAR đã build sẵn lên Tomcat 10
FROM tomcat:10.1-jdk17

# Xóa các app mặc định của Tomcat cho sạch sẽ
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy trực tiếp file WAR từ máy tính vào Docker
# (Không build bằng Ant trên cloud nữa vì lỗi thiếu thư viện NetBeans)
COPY dist/DEMO_duan.war /usr/local/tomcat/webapps/ROOT.war

# Mở cổng 8080
EXPOSE 8080

# Chạy Tomcat
CMD ["catalina.sh", "run"]
