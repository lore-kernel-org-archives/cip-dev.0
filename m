From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 17 Jul 2019 07:40:59 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 2/6] arm64: dts: renesas:
 r8a774c0-cat874: Add RWDT support
In-Reply-To: <20190716202735.GD9557@amd>
References: <1563200930-39297-1-git-send-email-biju.das@bp.renesas.com>
	<1563200930-39297-3-git-send-email-biju.das@bp.renesas.com>
	<20190716202735.GD9557@amd>
Message-ID: <OSBPR01MB2103A1E0EA93551375549E70B8C90@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [cip-dev] [PATCH 4.19.y-cip 2/6] arm64: dts: renesas: r8a774c0-
> cat874: Add RWDT support
> 
> On Mon 2019-07-15 15:28:46, Biju Das wrote:
> > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> >
> > commit 79223ca1f57776d2770da9561c26cc2f2dd42205 upstream.
> >
> > Enable RWDT and use 60 seconds as default timeout.
> 
> So this will reboot machine if userspace does not ping it within 60 seconds by
> default?

Yes,  if you enable watchdog  in user space and there is no ping activity for 60 sec.
We can verify this by using the below  command

cat > /dev/watchdog0 & for i in $(seq 100); do echo $i; sleep 1; done

> Will that break user configurations that worked up till now, but do not
> contain watchdog support?
> 
> Do we care?
> 

 As per  [1]
- timeout-sec : Contains the watchdog timeout in seconds
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt?h=v5.2

If time-out is not specified, then it uses the default timeout mentioned by the driver.

Regards,
Biju
> 
> > @@ -137,6 +137,11 @@
> >  	};
> >  };
> >
> > +&rwdt {
> > +	timeout-sec = <60>;
> > +	status = "okay";
> > +};
> > +
> >  &scif2 {
> >  	pinctrl-0 = <&scif2_pins>;
> >  	pinctrl-names = "default";
> 
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
