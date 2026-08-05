# Bước 1: Build file WAR bằng Ant
FROM eclipse-temurin:17-jdk-alpine AS builder

# Cài đặt Apache Ant
RUN apk add --no-cache apache-ant

# Tạo thư mục làm việc
WORKDIR /app

# Copy toàn bộ mã nguồn vào Docker
COPY . .

# Chạy lệnh Ant để biên dịch dự án ra file WAR (nằm trong thư mục dist/)
RUN ant -f build.xml clean build

# Bước 2: Triển khai file WAR lên Tomcat 10
FROM tomcat:10.1-jdk17

# Xóa các app mặc định của Tomcat cho sạch sẽ
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy file WAR từ bước 1 sang thư mục webapps của Tomcat
# Đổi tên thành ROOT.war để web chạy ngay tại tên miền chính (ví dụ: domain.com/ thay vì domain.com/DEMO_duan/)
COPY --from=builder /app/dist/DEMO_duan.war /usr/local/tomcat/webapps/ROOT.war

# Mở cổng 8080
EXPOSE 8080

# Chạy Tomcat
CMD ["catalina.sh", "run"]
