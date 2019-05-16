From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 16 May 2019 10:39:35 +0100
Subject: [cip-dev] [PATCH v2 23/52] dt-bindings: gpio: Add a
	gpio-reserved-ranges property
In-Reply-To: <1557999604-1117-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557999604-1117-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557999604-1117-24-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Stephen Boyd <sboyd@codeaurora.org>

commit b9c725ed73b7cecc7c9bc4b752ab3eb975ef9330 upstream.

Some qcom platforms make some GPIOs or pins unavailable for use
by non-secure operating systems, and thus reading or writing the
registers for those pins will cause access control issues.
Introduce a DT property to describe the set of GPIOs that are
available for use so that higher level OSes are able to know what
pins to avoid reading/writing.

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Tested-by: Timur Tabi <timur@codeaurora.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

---
v1->v2:
* No change
---
 Documentation/devicetree/bindings/gpio/gpio.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio.txt b/Documentation/devicetree/bindings/gpio/gpio.txt
index 069cdf6..6550775 100644
--- a/Documentation/devicetree/bindings/gpio/gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio.txt
@@ -141,9 +141,9 @@ in a lot of designs, some using all 32 bits, some using 18 and some using
 first 18 GPIOs, at local offset 0 .. 17, are in use.
 
 If these GPIOs do not happen to be the first N GPIOs at offset 0...N-1, an
-additional bitmask is needed to specify which GPIOs are actually in use,
-and which are dummies. The bindings for this case has not yet been
-specified, but should be specified if/when such hardware appears.
+additional set of tuples is needed to specify which GPIOs are unusable, with
+the gpio-reserved-ranges binding. This property indicates the start and size
+of the GPIOs that can't be used.
 
 Example:
 
@@ -153,6 +153,7 @@ gpio-controller at 00000000 {
 	gpio-controller;
 	#gpio-cells = <2>;
 	ngpios = <18>;
+	gpio-reserved-ranges = <0 4>, <12 2>;
 }
 
 The GPIO chip may contain GPIO hog definitions. GPIO hogging is a mechanism
-- 
2.7.4
