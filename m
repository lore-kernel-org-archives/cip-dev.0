From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 21 Oct 2019 06:48:07 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 3/6] dt-bindings: can: rcar_canfd:
 document r8a774a1 support
In-Reply-To: <20191018164933.GA25992@amd>
References: <1571295479-39328-1-git-send-email-biju.das@bp.renesas.com>
	<1571295479-39328-4-git-send-email-biju.das@bp.renesas.com>
	<20191018164933.GA25992@amd>
Message-ID: <OSBPR01MB21038E1ED0AA8E4E9EAF3F3FB8690@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 4.19.y-cip 3/6] dt-bindings: can: rcar_canfd: document
> r8a774a1 support
> 
> Hi!
> 
> > @@ -29,10 +30,10 @@ enable/disable the respective channel.
> >
> >  Required properties for "renesas,r8a774c0-canfd",
> > "renesas,r8a7795-canfd" and  "renesas,r8a7796-canfd" compatible:
> > -In R8A774C0, R8A7795 and R8A7796 SoCs, canfd clock is a div6 clock
> > and can be -used by both CAN and CAN FD controller at the same time.
> > It needs to be scaled -to maximum frequency if any of these
> > controllers use it. This is done using the -below properties:
> > +In R8A774A1, R8A774C0, R8A7795 and R8A7796 SoCs, canfd clock is a
> > +div6 clock and can beused by both CAN and CAN FD controller at the
> > +same time. It needs
> 
> This should be "be used", but I'd propose fixing it in the mainline and
> applying this series anyway.

Good Catch. Yes this to be fixed it in the Upstream first.

Cheers,
Biju
