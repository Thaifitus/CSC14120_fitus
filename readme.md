# mini-dnn-cpp

**mini-dnn-cpp** là phần cài đặt mạng neuron học sâu, được triển khai hoàn toàn bằng C++. Phần phụ thuộc duy nhất được tác giả sử dụng là Eigen và chỉ dùng làm phần header.

Cài đặt nguồn: [mini-dnn-cpp](https://github.com/iamhankai/mini-dnn-cpp.git)


## Cài đặt và sử dụng

### Git clone
```shell
git clone https://github.com/Thaifitus/lap_trinh_song_song-CSC14120_20KHMT.git
```

### Thay đổi đường dẫn đến thư mục và nhập các câu lệnh sau
```shell
mkdir build
cd build
cmake ..
make
```

Chạy `./demo`.

### Sửa lỗi
* **No CMAKE_CXX_COMPILER could be found**: đối với ubuntu (wsl), chạy câu lệnh sau ([nguồn: stackoverflow](https://stackoverflow.com/questions/32801638/cmake-error-at-cmakelists-txt30-project-no-cmake-c-compiler-could-be-found))

```shell
$ sudo apt-get update && sudo apt-get install build-essential
```

## Kết quả
![Kết quả trên fashion mnist](https://github.com/Thaifitus/lap_trinh_song_song-CSC14120_20KHMT/blob/master/Report/result_30-11-2023.png)

# CẤU TRÚC MÃ NGUỒN CỦA TÁC GIẢ

THƯ MỤC:
* src
  * layer: cài đặt các tầng convolution, pooling, hàm kích hoạt dựa trên interface ở file layer.h.
  * loss: cài đặt hàm đo độ lỗi (cross entropy, mse).
  * optimizer: cài đặt stochastic gradient descent.

* data: chứa bộ dữ liệu Fashion-MNIST.
* third_party: chứa thư viện eigen hỗ trợ tính toán đại số.


TẬP TIN (đa số ở thư mục src):
* mnist: đọc tập dữ liệu mnist. Dữ liệu sẽ được xử lý theo cột: mỗi cột sẽ tương ứng với một ảnh trắng đen (một kênh màu) gồm 28x28 dòng thể hiện cho mỗi pixel.

* layer.h: cài đặt interface cho các tầng convolution, pooling.

* network: cấu tạo của mô hình, chứa các layer và hoạt động của mỗi layer.

* demo.cc: tập tin chính của chương trình, gồm cấu trúc và quá trình huấn luyện mô hình.

MỘT VÀI BIẾN SỐ CỦA CHƯƠNG TRÌNH:
* channel: số kênh của dữ liệu. Nếu tầng convolution có channel_out=3 nghĩa là có 3 neuron (tương ứng 3 kernel) ở tầng này.

* dim (với các tầng khác dense): số lượng pixel của ảnh, có giá trị bằng height x width x channel.

* dim (với dense layer): số lượng neuron của tầng.

* Quá trình nhân tích chập và pooling sẽ làm tròn phần tử lên với trường hợp dữ liệu có số lượng lẻ. Kết quả cuối cùng phụ thuộc vào nhiều yếu tố như stride, padding...


Dữ liệu bao gồm các ảnh trắng đen (có 1 kênh màu) được cấu trúc và xử lý theo ma trận cột, trong đó mỗi cột là một ảnh và 28x28 dòng cho mỗi pixel. Các tầng khác nhau có phương thức foward tương ứng với hành vi của tầng.


Thư mục `Report` chứa file báo cáo (ipynb) và các tài liệu liên quan.