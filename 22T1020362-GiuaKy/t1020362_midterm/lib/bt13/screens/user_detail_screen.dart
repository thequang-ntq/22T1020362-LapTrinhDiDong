import 'package:flutter/material.dart';
import 'package:t1020362_midterm/bt13/data/api.dart';
import 'package:t1020362_midterm/bt13/model/user.dart';
import 'package:t1020362_midterm/bt13/screens/login_screen.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({super.key});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  User? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  Future<void> _loadUserDetails() async {
    try {
      User? user = await testAPI.getUserDetails();
      setState(() {
        _user = user;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Lỗi khi tải thông tin: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _handleLogout() {
    testAPI.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Color.fromARGB(255, 14, 128, 226)),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          value,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 20, 16, 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 14, 128, 226),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        title: Text(
          "Chi tiết người dùng",
          style: TextStyle(
            fontSize: w * 0.05,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 14, 128, 226),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 14, 128, 226),
              ),
            )
          : _user == null
              ? Center(
                  child: Text(
                    "Không thể tải thông tin người dùng",
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header với avatar
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 14, 128, 226),
                              Color.fromARGB(255, 30, 150, 243),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(_user!.image),
                              backgroundColor: Colors.white,
                            ),
                            SizedBox(height: 12),
                            Text(
                              "${_user!.firstName} ${_user!.lastName}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "@${_user!.username}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                _user!.role.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Thông tin cá nhân
                      _buildSectionTitle("THÔNG TIN CÁ NHÂN"),
                      _buildInfoCard("Email", _user!.email, Icons.email),
                      _buildInfoCard("Số điện thoại", _user!.phone, Icons.phone),
                      _buildInfoCard(
                          "Giới tính",
                          _user!.gender == "male" ? "Nam" : "Nữ",
                          Icons.person),
                      _buildInfoCard("Tuổi", "${_user!.age} tuổi", Icons.cake),
                      _buildInfoCard(
                          "Ngày sinh", _user!.birthDate, Icons.calendar_today),
                      _buildInfoCard(
                          "Họ khai sinh", _user!.maidenName, Icons.family_restroom),

                      // Thông tin sức khỏe
                      _buildSectionTitle("THÔNG TIN SỨC KHỎE"),
                      _buildInfoCard(
                          "Nhóm máu", _user!.bloodGroup, Icons.bloodtype),
                      _buildInfoCard("Chiều cao",
                          "${_user!.height.toStringAsFixed(2)} cm", Icons.height),
                      _buildInfoCard("Cân nặng",
                          "${_user!.weight.toStringAsFixed(2)} kg", Icons.monitor_weight),
                      _buildInfoCard(
                          "Màu mắt", _user!.eyeColor, Icons.remove_red_eye),
                      _buildInfoCard(
                          "Tóc",
                          "${_user!.hair.color} - ${_user!.hair.type}",
                          Icons.face),

                      // Địa chỉ
                      _buildSectionTitle("ĐỊA CHỈ"),
                      _buildInfoCard(
                          "Địa chỉ", _user!.address.address, Icons.home),
                      _buildInfoCard("Thành phố", _user!.address.city, Icons.location_city),
                      _buildInfoCard(
                          "Tiểu bang",
                          "${_user!.address.state} (${_user!.address.stateCode})",
                          Icons.map),
                      _buildInfoCard(
                          "Mã bưu điện", _user!.address.postalCode, Icons.markunread_mailbox),
                      _buildInfoCard(
                          "Quốc gia", _user!.address.country, Icons.flag),

                      // Thông tin công ty
                      _buildSectionTitle("CÔNG TY"),
                      _buildInfoCard(
                          "Tên công ty", _user!.company.name, Icons.business),
                      _buildInfoCard(
                          "Phòng ban", _user!.company.department, Icons.group),
                      _buildInfoCard(
                          "Chức vụ", _user!.company.title, Icons.work),

                      // Thông tin ngân hàng
                      _buildSectionTitle("NGÂN HÀNG"),
                      _buildInfoCard(
                          "Số thẻ", _user!.bank.cardNumber, Icons.credit_card),
                      _buildInfoCard(
                          "Loại thẻ", _user!.bank.cardType, Icons.payment),
                      _buildInfoCard(
                          "Hết hạn", _user!.bank.cardExpire, Icons.date_range),
                      _buildInfoCard(
                          "Tiền tệ", _user!.bank.currency, Icons.attach_money),
                      _buildInfoCard("IBAN", _user!.bank.iban, Icons.account_balance),

                      // Thông tin khác
                      _buildSectionTitle("THÔNG TIN KHÁC"),
                      _buildInfoCard(
                          "Đại học", _user!.university, Icons.school),
                      _buildInfoCard("IP Address", _user!.ip, Icons.router),
                      _buildInfoCard(
                          "MAC Address", _user!.macAddress, Icons.devices),
                      _buildInfoCard("EIN", _user!.ein, Icons.badge),
                      _buildInfoCard("SSN", _user!.ssn, Icons.security),

                      // Crypto
                      _buildSectionTitle("CRYPTO"),
                      _buildInfoCard("Coin", _user!.crypto.coin, Icons.currency_bitcoin),
                      _buildInfoCard(
                          "Wallet", _user!.crypto.wallet, Icons.account_balance_wallet),
                      _buildInfoCard(
                          "Network", _user!.crypto.network, Icons.network_check),

                      SizedBox(height: 30),

                      // Nút Đăng xuất
                      Center(
                        child: SizedBox(
                          width: w * 0.5,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                Colors.red[600],
                              ),
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            onPressed: _handleLogout,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: h * 0.012),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.logout,
                                    size: w * 0.055,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: w * 0.025),
                                  Text(
                                    "Đăng xuất",
                                    style: TextStyle(
                                      fontSize: w * 0.055,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
    );
  }
}