From: pavel@denx.de (Pavel Machek)
Date: Tue, 16 Jul 2019 22:27:35 +0200
Subject: [cip-dev] [PATCH 4.19.y-cip 2/6] arm64: dts: renesas:
 r8a774c0-cat874: Add RWDT support
In-Reply-To: <1563200930-39297-3-git-send-email-biju.das@bp.renesas.com>
References: <1563200930-39297-1-git-send-email-biju.das@bp.renesas.com>
	<1563200930-39297-3-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20190716202735.GD9557@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Mon 2019-07-15 15:28:46, Biju Das wrote:
> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> 
> commit 79223ca1f57776d2770da9561c26cc2f2dd42205 upstream.
> 
> Enable RWDT and use 60 seconds as default timeout.

So this will reboot machine if userspace does not ping it within 60
seconds by default?

Will that break user configurations that worked up till now, but do
not contain watchdog support?

Do we care?

Thanks,
								Pavel

> @@ -137,6 +137,11 @@
>  	};
>  };
>  
> +&rwdt {
> +	timeout-sec = <60>;
> +	status = "okay";
> +};
> +
>  &scif2 {
>  	pinctrl-0 = <&scif2_pins>;
>  	pinctrl-names = "default";

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190716/ee60b189/attachment-0001.sig>
