From: marian-cristian.rotariu.rb@bp.renesas.com (Marian-Cristian Rotariu)
Date: Tue, 18 Feb 2020 14:05:10 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 13/23] dt-bindings: usb: hd3ss3220
	device tree binding document
In-Reply-To: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <1582034720-5249-14-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit 1918fa0d44985cbc8ab2f315c120525b207b2195 upstream.

Add device tree binding document for TI HD3SS3220 Type-C DRP port
controller driver.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/1567584941-13690-2-git-send-email-biju.das at bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 .../devicetree/bindings/usb/ti,hd3ss3220.txt       | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,hd3ss3220.txt

diff --git a/Documentation/devicetree/bindings/usb/ti,hd3ss3220.txt b/Documentation/devicetree/bindings/usb/ti,hd3ss3220.txt
new file mode 100644
index 0000000..25780e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ti,hd3ss3220.txt
@@ -0,0 +1,38 @@
+TI HD3SS3220 TypeC DRP Port Controller.
+
+Required properties:
+ - compatible: Must be "ti,hd3ss3220".
+ - reg: I2C slave address, must be 0x47 or 0x67 based on ADDR pin.
+ - interrupts: An interrupt specifier.
+
+Required sub-node:
+ - connector: The "usb-c-connector" attached to the hd3ss3220 chip. The
+   bindings of the connector node are specified in:
+
+	Documentation/devicetree/bindings/connector/usb-connector.txt
+
+Example:
+hd3ss3220 at 47 {
+	compatible = "ti,hd3ss3220";
+	reg = <0x47>;
+	interrupt-parent = <&gpio6>;
+	interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+
+	connector {
+		compatible = "usb-c-connector";
+		label = "USB-C";
+		data-role = "dual";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 1 {
+				reg = <1>;
+				hd3ss3220_ep: endpoint {
+					remote-endpoint = <&usb3_role_switch>;
+				};
+			};
+		};
+	};
+};
-- 
2.7.4
