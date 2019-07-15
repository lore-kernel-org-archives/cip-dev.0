From: pavel@denx.de (Pavel Machek)
Date: Mon, 15 Jul 2019 14:24:13 +0200
Subject: [cip-dev] [ANNOUNCE] 4.4.176-cip31-rt23
In-Reply-To: <a86d4f19-790d-58ab-94b4-523a759d87b4@siemens.com>
References: <20190329110611.1B897500722@mail.monom.org>
	<a86d4f19-790d-58ab-94b4-523a759d87b4@siemens.com>
Message-ID: <20190715122413.GA16268@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> > I'm pleased to announce the 4.4.176-cip31-rt23 stable release.
> > 
> > This release is just an update to the new stable 4.4.176-cip31 version
> > and no RT specific changes have been made.
> > 
> > You can get this release via the git tree at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
> > 
> >   branch: linux-4.4.y-cip-rt
> >   Head SHA1: b51a171ad762ba4a78b0ed0c7ec83fb9f6fb135f
> > 
> 
> Is there a chance to update 4.4-rt based on Daniel' 4.4.179-rt181 release, but
> then to 4.4.182 in order to have SACK fixes in?

I'm looking into it. I have -rt-rebase based on
v4.4.179-rt181-cip34-rebase (close to what you want but not quite
there; I can publish it if it would be useful), but duplicating same
result with merges might be tricky.

Best regards,
								Pavel

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190715/7b122d3c/attachment.sig>
