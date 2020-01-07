From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 7 Jan 2020 13:06:19 +0100
Subject: [cip-dev] Difference between v4.19.88-cip16-rebase..v4.19.88-cip16
 was Re: Getting older -cip-rebase versions
In-Reply-To: <OSAPR01MB3667987C41E9C68D6D0F5D6E923C0@OSAPR01MB3667.jpnprd01.prod.outlook.com>
References: <20191229172557.GA18039@duo.ucw.cz>
 <OSAPR01MB3667987C41E9C68D6D0F5D6E923C0@OSAPR01MB3667.jpnprd01.prod.outlook.com>
Message-ID: <20200107120619.GB1234@duo.ucw.cz>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> > Is there way to get to that version? Would it be possible to keep those
> > tags in future?
> 
> Please use 'git fetch --tags' .
> With git normal commands, you can only get tags that are reachable from the branch.
> In this case, execute as above.

Thanks a lot for the pointer.

I'm trying to prepare -cip-rt release, and I ran into differences I
could not explain. After some head scratching, I realized they are in
-cip, too:

diff v4.19.88-cip16-rebase..v4.19.88-cip16.

One more line of difference exists in newer version: git diff
v4.19.91-cip17-rebase..v4.19.91-cip17

Any idea what is going on there? Which version is ok and which should
be adjusted?

Best regards,
									Pavel

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index 86228e0596cb..570093ce77be 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -1550,56 +1550,267 @@
 				};
 			};
 
+			rcar_sound,ssiu {
+				ssiu00: ssiu-0 {
+					dmas = <&audma0 0x15>, <&audma1 0x16>;
+					dma-names = "rx", "tx";
+				};
...
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7264.c
@@ -1766,7 +1766,6 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PF0MD_000, PF0MD_001, PF0MD_010, PF0MD_011,
 		PF0MD_100, PF0MD_101, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0 ))
-	 }
 	},
 
 	{ PINMUX_CFG_REG("PFIOR0", 0xfffe38b2, 16, 1, GROUP(


-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 195 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20200107/f8706a16/attachment.sig>
