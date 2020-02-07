From: pavel@denx.de (Pavel Machek)
Date: Fri, 7 Feb 2020 14:10:03 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 20/35] arm64: dts: renesas:
 hihope-rzg2-ex: Add LVDS support
In-Reply-To: <1580935141-1173-21-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1580935141-1173-21-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <20200207131003.GB5989@duo.ucw.cz>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> +&lvds0 {
> +	/*
> +	 * Please include the LVDS panel .dtsi file and uncomment the below line
> +	 * to enable LVDS panel connected to RZ/G2[MN] boards.
> +	 */
> +
> +	/* status = "okay"; */
> +
> +	ports {
> +		port at 1 {
> +			lvds_connector: endpoint {
> +			};
> +		};
> +	};
> +};

Mainline does this so I applied it, but I don't believe you want
boards to modify the dtsi -- it will get problematic if you want to
support two different boards with different LVDS panels in one source
code.

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20200207/3027cd9c/attachment.sig>
