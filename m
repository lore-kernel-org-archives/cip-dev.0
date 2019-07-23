From: pavel@denx.de (Pavel Machek)
Date: Tue, 23 Jul 2019 23:12:19 +0200
Subject: [cip-dev] [ANNOUNCE] v4.4.185-cip35-rt24
In-Reply-To: <20190723124015.GA13044@amd>
References: <20190723124015.GA13044@amd>
Message-ID: <20190723211219.GB23154@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

v4.4.185-cip35-rt24 should be available at kernel.org.

Daniel says:
# in the v4.4-rt is still a problem with f01f17d3705b ("mm,
# vmstat: make quiet_vmstat lighter"). It is needed to boot on x86_64
# but it breaks on NVIDIA's boards, e.g. Jetson. Unfortunately, I don't
# have a NVIDIA board in my lab to figure out what is missing. So I
# suspect there is a still a problem hidden in the current v4.4-rt tree.

I did nothing to solve that problem. If someone uses NVIDIA boards,
let me know.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-cip-rt-rebase
 
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-cip-rt
  
And their content should be identical. It should be tagged and tag
should be signed.
 
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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190723/c22183e0/attachment.sig>
