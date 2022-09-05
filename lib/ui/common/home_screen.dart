import '../../controllers/home_controller.dart';
import '../../util/import_export_util.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = ResponsiveUtil.isMobile(context)
        ? DeviceType.mobile
        : DeviceType.desktop;

    return Scaffold(
      appBar: AppBarComponent.buildAppbarForHome(
        titleWidget: Text(
          StringConstant.homeLabel.tr,
          textDirection: TextDirection.ltr,
          style: deviceType == DeviceType.mobile
              ? white100Medium22TextStyle(context)
              : white100Medium10TextStyle(context),
        ),
      ),
      body: Container(),
    );
  }
}
