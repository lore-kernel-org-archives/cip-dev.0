From: pavel@denx.de (Pavel Machek)
Date: Fri, 7 Feb 2020 14:11:08 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 24/35] arm64: dts: renesas:
 r8a774b1: Add Sound and Audio DMAC device nodes
In-Reply-To: <1580935141-1173-25-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1580935141-1173-25-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <20200207131108.GC5989@duo.ucw.cz>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> From: Biju Das <biju.das@bp.renesas.com>
> 
> commit 067eca6dc61ad3d05ba919cd5a10affc0647e19c upstream.
> 
> Based on a similar patch of the R8A7796 device tree
> by Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>.

> @@ -1236,24 +1236,478 @@
>  		};
>  
>  		rcar_sound: sound at ec500000 {
> +			/*
> +			 * #sound-dai-cells is required
> +			 *
> +			 * Single DAI : #sound-dai-cells = <0>;	<&rcar_sound>;
> +			 * Multi  DAI : #sound-dai-cells = <1>;	<&rcar_sound N>;
> +			 */
> +			/*
> +			 * #clock-cells is required for audio_clkout0/1/2/3
> +			 *
> +			 * clkout	: #clock-cells = <0>;	<&rcar_sound>;
> +			 * clkout0/1/2/3: #clock-cells = <1>;	<&rcar_sound N>;
> +			 */
> +			compatible =  "renesas,rcar_sound-r8a774b1", "renesas,rcar_sound-gen3";

There is extra space after "=".

Best regards,
								Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 195 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20200207/c8de4105/attachment.sig>
