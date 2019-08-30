From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 30 Aug 2019 09:34:06 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip v2 56/57] arm64: dts: Remove
 inconsistent use of 'arm, armv8' compatible string
In-Reply-To: <20190830090958.GB18867@amd>
References: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1566999164-27898-57-git-send-email-fabrizio.castro@bp.renesas.com>
	<TY1PR01MB177044D5252F7954B4C9DF05C0BD0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
	<20190830090958.GB18867@amd>
Message-ID: <TYXPR01MB17754E8CA547CDCAC6559774C0BD0@TYXPR01MB1775.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: 30 August 2019 10:10
> Subject: Re: [cip-dev][PATCH 4.19.y-cip v2 56/57] arm64: dts: Remove inconsistent use of 'arm,armv8' compatible string
> 
> Hi!
> 
> > >It's not that important, but why is there a space between 'arm,' and 'armv8'
> > >in subject?
> > >Original subject does not have space.
> >
> > It is actually VERY, VERY, important, as the email I have sent out doesn't contain the space.
> > I have even run hexdump on the patch file on my disk, it confirms there is no space.
> > I am replying to my own email, and as you can see, there is no
> >space.
> 
> Can you take a look at the email, as received from the mailinglist? I
> see a space in subject, between 'arm,' and 'armv8'.

Interesting...

> 
> Can you send the original email, as a binary attachment?

I use git send-email, therefore unfortunately I don't have the original email.
I have attached the email msg as received from my email client, and the patch file.
It doesn't look like there is a space there...

In both cases:
* "arm64: dts: Remove inconsistent use of 'arm,armv8' compatible string", and
* "soc: renesas: rcar-sysc: Remove rcar_sysc_power_{down,up}() helpers"
it seems like a space was added after the comma, like autocorrect programs would
do...

Has anybody seen this before?

Thanks,
Fab

> 
> > >The following patch have similar problem.
> > >soc: renesas: rcar-sysc: Remove rcar_sysc_power_{down, up}() helpers
> >
> > Same thing here, there is no space in the email I have sent out, which means it's
> > probably down to patchwork? Somehow a space gets automatically added, I wonder if
> > this is happening with the code too?
> >
> > How do we find out if the problem is with patchwork?
> 
> I don't think patchwork is responsible. It would have to be something
> in the mailing list.
> 
> Best regards,
> 								Pavel
> 
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
An embedded message was scrubbed...
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [cip-dev][PATCH 4.19.y 59/60] arm64: dts: Remove inconsistent use of
 'arm,armv8' compatible string
Date: Wed, 28 Aug 2019 11:03:30 +0000
Size: 8561
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190830/17487f6d/attachment.mht>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0056-arm64-dts-Remove-inconsistent-use-of-arm-armv8-compa.patch
Type: application/octet-stream
Size: 3671 bytes
Desc: 0056-arm64-dts-Remove-inconsistent-use-of-arm-armv8-compa.patch
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190830/17487f6d/attachment.obj>
