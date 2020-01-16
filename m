From: pavel@denx.de (Pavel Machek)
Date: Thu, 16 Jan 2020 16:29:53 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 10/12] arm64: dts: renesas:
 r8a774c0: cat874: Add definition for 12V regulator
In-Reply-To: <1579187482-4626-11-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1579187482-4626-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1579187482-4626-11-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <20200116152953.GB27135@duo.ucw.cz>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> 
> commit 7fc009cbd7d11d6b27ba5443dbfa80a0513829e4 upstream.
> 
> Power rail "D12.0V" comes straight from the power barrel connector,
> and it's used in both main board and sub board.

Given that line is always on, always constant, and not referenced
anywhere, does it need to be described in the dts?

Will it be used in future?

Best regards,
								Pavel

> @@ -65,6 +65,15 @@
>  		reg = <0x0 0x48000000 0x0 0x78000000>;
>  	};
>  
> +	reg_12p0v: regulator-12p0v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "D12.0V";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
>  	sound: sound {
>  		compatible = "simple-audio-card";
>  
> -- 
> 2.7.4
> 

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 195 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20200116/7fc3d9a5/attachment.sig>
