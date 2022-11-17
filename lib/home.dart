import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController hostAddressController = TextEditingController();
  final TextEditingController packetCountController = TextEditingController();
  final TextEditingController spoofedIpController = TextEditingController();
  final TextEditingController hostIpPortController = TextEditingController();
  final TextEditingController autoTimeOutController = TextEditingController();
  final TextEditingController dataSizeController = TextEditingController();

  String? mode = 'tcp';
  String? packetSpeed = 'fast';
  bool randSource = false;
  String? hostAddressErrorText;
  String? packetCountErrorText;
  String? hostIpPortErrorText;
  String? autoTimeOutErrorText;
  String? dataSizeErrorText;

  bool isSyn = false;
  bool isFin = false;
  bool isRst = false;
  bool isPush = false;
  bool isAck = false;
  bool isUrg = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/bg.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(20),
                width: min(MediaQuery.of(context).size.width / 2, 500),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        "DOS Attacker",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        "Perform Denial of Service with ease",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Target IP address*",
                      style: TextStyle(color: Colors.blue),
                    ),
                    TextField(
                      controller: hostAddressController,
                      decoration: InputDecoration(
                        hintText: "www.google.com",
                        errorText: hostAddressErrorText,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Target IP port",
                      style: TextStyle(color: Colors.blue),
                    ),
                    TextField(
                      controller: hostIpPortController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "3000",
                        errorText: hostIpPortErrorText,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Packet count",
                      style: TextStyle(color: Colors.blue),
                    ),
                    TextField(
                      controller: packetCountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "10",
                        errorText: packetCountErrorText,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Data size",
                      style: TextStyle(color: Colors.blue),
                    ),
                    TextField(
                      controller: dataSizeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "20",
                        errorText: dataSizeErrorText,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Mode",
                              style: TextStyle(color: Colors.blue),
                            ),
                            SizedBox(
                              child: DropdownButton<String>(
                                value: mode,
                                items: <String>['tcp', 'icmp', 'rawip', 'udp']
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  setState(() {
                                    mode = val;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Packet Speed",
                              style: TextStyle(color: Colors.blue),
                            ),
                            SizedBox(
                              child: DropdownButton<String>(
                                value: packetSpeed,
                                items: <String>['fast', 'faster', 'flood']
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  setState(() {
                                    packetSpeed = val;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Random Source IP",
                              style: TextStyle(color: Colors.blue),
                            ),
                            SizedBox(
                              child: DropdownButton<bool>(
                                value: randSource,
                                items: <bool>[true, false].map((bool value) {
                                  return DropdownMenuItem<bool>(
                                    value: value,
                                    child: Text(value.toString()),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  setState(() {
                                    randSource = val!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Spoofed IP",
                      style: TextStyle(color: Colors.blue),
                    ),
                    TextField(
                      controller: spoofedIpController,
                      decoration: const InputDecoration(
                        hintText: "www.myspoofip.com",
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "TCP/UPD Flags",
                      style: TextStyle(color: Colors.blue),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        const Text("syn"),
                        Checkbox(
                          checkColor: Colors.white,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: isSyn,
                          onChanged: (bool? value) {
                            setState(() {
                              isSyn = value!;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text("fin"),
                        Checkbox(
                          checkColor: Colors.white,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: isFin,
                          onChanged: (bool? value) {
                            setState(() {
                              isFin = value!;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text("rst"),
                        Checkbox(
                          checkColor: Colors.white,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: isRst,
                          onChanged: (bool? value) {
                            setState(() {
                              isRst = value!;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text("push"),
                        Checkbox(
                          checkColor: Colors.white,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: isPush,
                          onChanged: (bool? value) {
                            setState(() {
                              isPush = value!;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text("ack"),
                        Checkbox(
                          checkColor: Colors.white,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: isAck,
                          onChanged: (bool? value) {
                            setState(() {
                              isAck = value!;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text("urg"),
                        Checkbox(
                          checkColor: Colors.white,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: isUrg,
                          onChanged: (bool? value) {
                            setState(() {
                              isUrg = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Auto timeout attack in (seconds)*",
                      style: TextStyle(color: Colors.blue),
                    ),
                    TextField(
                      controller: autoTimeOutController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "10",
                        errorText: autoTimeOutErrorText,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () => performAttack(),
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                            backgroundColor: Colors.red),
                        child: const Text(
                          "Attack",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  bool isNumeric(String? str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  Future<void> performAttack() async {
    String? targetAddress = hostAddressController.text;
    String? packetCount = packetCountController.text;
    String? spoofedIp = spoofedIpController.text;
    String? port = hostIpPortController.text;
    String? timeout = autoTimeOutController.text;
    String? dataSize = dataSizeController.text;
    var flags = [];

    if (targetAddress == "") {
      setState(() {
        hostAddressErrorText = "Target address is required";
      });
      return;
    }
    if (packetCount != "") {
      if (packetCount == "0") {
        setState(() {
          packetCountErrorText = "Packet count should be greater than 0";
        });
        return;
      }
    }
    if (timeout == "") {
      setState(() {
        autoTimeOutErrorText = "Timout value is required";
      });
      return;
    }
    if (!isNumeric(timeout)) {
      setState(() {
        autoTimeOutErrorText = "Timeout value should be numeric";
      });
      return;
    }
    if (dataSize != "") {
      if (!isNumeric(dataSize)) {
        setState(() {
          dataSizeErrorText = "Data size should be numeric";
        });
        return;
      }
    }

    if (isAck) flags.add('ack');
    if (isFin) flags.add('fin');
    if (isPush) flags.add('push');
    if (isRst) flags.add('rst');
    if (isSyn) flags.add('syn');
    if (isUrg) flags.add('urg');

    Map<String, dynamic> payload = {
      "hostAddr": targetAddress,
      "count": packetCount != "" ? int.parse(packetCount) : null,
      "mode": mode,
      "spoofIp": spoofedIp == "" ? null : spoofedIp,
      "randSource": randSource,
      "destPort": port == "" ? null : int.parse(port),
      "tcpFlags": flags,
      "dataSize": dataSize == "" ? null : int.parse(dataSize),
      "packetSpeed": packetSpeed,
      "timeout": int.parse(timeout),
    };

    Dio dio = Dio();
    const baseUrl = "http://localhost:3000";
    try {
      await dio.post("$baseUrl/attack", data: payload);
      final snackBar = SnackBar(
          content: Text(
              "Attack is successfull! will timout attack in $timeout seconds"));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      const snackBar = SnackBar(content: Text('Sorry! something went wrong'));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
}
