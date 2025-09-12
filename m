Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B6ECAC597
	for <webhook@archiver.kernel.org>; Tue, 16 Sep 2025 00:32:19 +0000 (UTC)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
 by mx.groups.io with SMTP id smtpd.web11.15963.1757681443713737972
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Sep 2025 05:50:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GrNd3V3T;
 spf=pass (domain: gmail.com, ip: 209.85.210.45, mailfrom: sohaibfacebook396@gmail.com)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-746c06937c3so1450746a34.0
        for <cip-dev@lists.cip-project.org>; Fri, 12 Sep 2025 05:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757681442; x=1758286242; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J3aQ84vsV8aWYcuSfxcjosx1L5LYmzQ/GRq7132OLRI=;
        b=GrNd3V3T7AFdRUwfPB/cZcno9Z3m6P5Sn/SZwkIEr4fBnLosY3inPMd6Sp77G5R1TE
         QM8qBE2jVxJYKH27elruOZcsqCCb5mqyxAb1fpoWxbCQW4idFWledneXJYqc5ZQ9GDig
         9ERJsLaQ0p4TX/6U2PBiOOeboOtOR3ryqGqMsm2O7DHMUDptvA8HZTZBDT0ePXplQekd
         cA0efA4FHaNIh/k/G91JrBP7XJNTRfgNWNB9Kht3XMVzs1JklayYFJxJJvzVUXZ72WWO
         ocunrVJQi0pYA6ksCMUrEhVtiWxm8sEjk8+gKehSFZGBncN5cVVy62p157iDmoc7lbQj
         ZMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757681442; x=1758286242;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3aQ84vsV8aWYcuSfxcjosx1L5LYmzQ/GRq7132OLRI=;
        b=ZtMwk/t7Ir37IFpNtAJVourFslI54YL2QrXT6wg/yGVt2wIrAKdG7UK82jNOKK8HKL
         RLOMh1EBamH0kLES6B+yrzNjLY4M80klQ1RTu6C4ki0VByMdvP0eFmmrlbOmrd473Qwp
         +fNATlP+tT+kl7Y5cjPGI8DJjkonYwIypz5vruy0jl3shfZo14CUJRfcZkZA5duq0zgK
         vsZsWCCRHGy2XgSm8/dtzO/v/e8q08nChq1/F6NIuOWwk6QsCMuyiOZMFbewPOrSWe5T
         curWdeFguroAKpwukoThD/l0/60xwB+jREYN1+dEkItxbC8yomI50Gk2g47lJwBZaSTz
         SE6A==
X-Gm-Message-State: AOJu0YzZT2QyINiWhGoncMBQYbZRfT9W/lhfCkSZUtc4xkfWI/D3pEjh
	SJqG+SLdf+u9/0u4bfVb4/Sc+/ax2YLG42w7HsCqptCtb/hTqL5GsMBWQyPwwvC4TusJifz4yEX
	IKm5cSE2uBXuyONLnDq0Q/ahDtjb7R8Q+Cg==
X-Gm-Gg: ASbGncvoo6WkMhIQ5xzqWfx9lkLPw/OGdSlhyfzK05Yn7PyOL/eUG3kjY0/oTYEF/eL
	vYBM0dhGyKzO8tv/kU0+09SoxoeZTOwLMMTv6wHzeM/SLuxFmIww0OnTiQonwERc3arikWL5pep
	x+lZeSvi0xwlhswAHHSP3+0PbbnQ2WTFk8uAmA/TQ+6Y2j8OCaRU8LRxgeANY71mskIrHYt3TrY
	sMaED2xjEI2P1bJdg==
X-Google-Smtp-Source: AGHT+IFRc68F5WV/TzGwowv8PkFjElnVVkBP2/pCbNiuhmJsj6V9R1DNPwNZGeQ+AAEE9SgU1/a28owVeap2aMz5pCI=
X-Received: by 2002:a17:902:d4c2:b0:25c:cfe2:a10f with SMTP id
 d9443c01a7336-25ccfe2a5a8mr48000445ad.30.1757681046545; Fri, 12 Sep 2025
 05:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAC=y2wxfBD8ZEc_wmCtyW147kCw2P_sCrfWXdthZyYxYYxHeAQ@mail.gmail.com>
In-Reply-To: <CAC=y2wxfBD8ZEc_wmCtyW147kCw2P_sCrfWXdthZyYxYYxHeAQ@mail.gmail.com>
From: Sohaib Mohammed <sohaibfacebook396@gmail.com>
Date: Fri, 12 Sep 2025 14:43:55 +0200
X-Gm-Features: Ac12FXw1h2p-ZKA_dpVgRkMPr_MWnDuhnCf1NK6MYuWnVs5SmJdaB5hMFXQkVZg
Message-ID: <CAC=y2wzPB8rBrhyTN7G7MU8vzpav8SpsniiedZ=ie8Z096ZY=A@mail.gmail.com>
Subject: GCC Toolchain Requirements for Linux v4.4.302-cip102 Build
To: cip-dev@lists.cip-project.org
Content-Type: multipart/alternative; boundary="000000000000686ad6063e9a0267"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Sep 2025 00:32:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20054

--000000000000686ad6063e9a0267
Content-Type: text/plain; charset="UTF-8"

Hello,

I am currently trying to build Linux kernel v4.4.302-cip102 and
encountering several warnings during the build process. I suspect these may
be related to using a more recent toolchain (GCC 14.x) than what is
officially supported for this kernel version.


*Build Warnings Encountered:*

LD      arch/arm/mm/built-in.o

warning: arch/arm/mm/l2c-l2x0-resume.o: missing .note.GNU-stack section
implies executable stack

NOTE: This behaviour is deprecated and will be removed in a future version
of the linker



warning: arch/arm/boot/compressed/bswapsdi2.o: missing .note.GNU-stack
section implies executable stack

NOTE: This behaviour is deprecated and will be removed in a future version
of the linker



warning: arch/arm/boot/compressed/vmlinux has a LOAD segment with RWX
permissions

*Questions:*

   1. What are the minimum and maximum supported GCC versions for building
   this CIP kernel?
   2. Is there official documentation specifying the recommended toolchain
   versions for Linux CIP 4.4?



Best regards,
Sohaib Radwan

--000000000000686ad6063e9a0267
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><span style=3D"font-size:1rem;word-spacing:1px;background=
-color:rgba(0,0,0,0);border-color:rgb(49,49,49);color:rgb(49,49,49)">Hello,=
</span><br></div><div><div class=3D"gmail_quote gmail_quote_container"><div=
><div><div><p style=3D"font-size:16px;font-style:normal;font-weight:400;let=
ter-spacing:normal;text-indent:0px;text-transform:none;white-space:normal;w=
ord-spacing:1px;text-decoration:none;background-color:rgba(0,0,0,0);border-=
color:rgb(49,49,49);color:rgb(49,49,49)"><span style=3D"font-size:1rem;back=
ground-color:rgba(0,0,0,0);border-color:rgb(49,49,49);color:rgb(49,49,49)">=
I am currently trying to build Linux kernel v4.4.302-cip102 and encounterin=
g several warnings during the build process. I suspect these may be related=
 to using a more recent toolchain (GCC 14.x) than what is officially suppor=
ted for this kernel version.<u style=3D"background-color:rgba(0,0,0,0);bord=
er-color:rgb(49,49,49);color:rgb(49,49,49)"></u><u style=3D"background-colo=
r:rgba(0,0,0,0);border-color:rgb(49,49,49);color:rgb(49,49,49)"></u></span>=
</p><p style=3D"font-size:16px;font-style:normal;font-weight:400;letter-spa=
cing:normal;text-indent:0px;text-transform:none;white-space:normal;word-spa=
cing:1px;text-decoration:none;background-color:rgba(0,0,0,0);border-color:r=
gb(49,49,49);color:rgb(49,49,49)"><span style=3D"background-color:rgba(0,0,=
0,0);border-color:rgb(49,49,49);color:rgb(49,49,49)"><br><b style=3D"font-s=
ize:1rem;background-color:rgba(0,0,0,0);border-color:rgb(49,49,49);color:rg=
b(49,49,49)">Build Warnings Encountered:</b><u style=3D"background-color:rg=
ba(0,0,0,0);border-color:rgb(49,49,49);color:rgb(49,49,49)"></u><u style=3D=
"background-color:rgba(0,0,0,0);border-color:rgb(49,49,49);color:rgb(49,49,=
49)"></u></span></p><p style=3D"font-size:16px;font-style:normal;font-weigh=
t:400;letter-spacing:normal;text-indent:0px;text-transform:none;white-space=
:normal;word-spacing:1px;text-decoration:none;background-color:rgba(0,0,0,0=
);border-color:rgb(49,49,49);color:rgb(49,49,49)"><span style=3D"font-size:=
1rem;background-color:rgba(0,0,0,0);border-color:rgb(49,49,49);color:rgb(49=
,49,49)">LD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arch/arm/mm/built-in.o<u style=3D=
"background-color:rgba(0,0,0,0);border-color:rgb(49,49,49);color:rgb(49,49,=
49)"></u><u style=3D"background-color:rgba(0,0,0,0);border-color:rgb(49,49,=
49);color:rgb(49,49,49)"></u></span></p><p style=3D"font-size:16px;font-sty=
le:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-transf=
orm:none;white-space:normal;word-spacing:1px;text-decoration:none;backgroun=
d-color:rgba(0,0,0,0);border-color:rgb(49,49,49);color:rgb(49,49,49)"><span=
 style=3D"font-size:1rem;background-color:rgba(0,0,0,0);border-color:rgb(49=
,49,49);color:rgb(49,49,49)">warning: arch/arm/mm/l2c-l2x0-resume.o: missin=
g .note.GNU-stack section implies executable stack<u style=3D"background-co=
lor:rgba(0,0,0,0);border-color:rgb(49,49,49);color:rgb(49,49,49)"></u><u st=
yle=3D"background-color:rgba(0,0,0,0);border-color:rgb(49,49,49);color:rgb(=
49,49,49)"></u></span></p><p style=3D"font-size:16px;font-style:normal;font=
-weight:400;letter-spacing:normal;text-indent:0px;text-transform:none;white=
-space:normal;word-spacing:1px;text-decoration:none;background-color:rgba(0=
,0,0,0);border-color:rgb(49,49,49);color:rgb(49,49,49)"><span style=3D"font=
-size:1rem;background-color:rgba(0,0,0,0);border-color:rgb(49,49,49);color:=
rgb(49,49,49)">NOTE: This behaviour is deprecated and will be removed in a =
future version of the linker<u style=3D"background-color:rgba(0,0,0,0);bord=
er-color:rgb(49,49,49);color:rgb(49,49,49)"></u><u style=3D"background-colo=
r:rgba(0,0,0,0);border-color:rgb(49,49,49);color:rgb(49,49,49)"></u></span>=
</p><p style=3D"font-size:16px;font-style:normal;font-weight:400;letter-spa=
cing:normal;text-indent:0px;text-transform:none;white-space:normal;word-spa=
cing:1px;text-decoration:none;background-color:rgba(0,0,0,0);border-color:r=
gb(49,49,49);color:rgb(49,49,49)"><span style=3D"background-color:rgba(0,0,=
0,0);border-color:rgb(49,49,49);color:rgb(49,49,49)"><u style=3D"background=
-color:rgba(0,0,0,0);border-color:rgb(49,49,49);color:rgb(49,49,49)"></u>=
=C2=A0<u style=3D"background-color:rgba(0,0,0,0);border-color:rgb(49,49,49)=
;color:rgb(49,49,49)"></u></span></p><p style=3D"font-size:16px;font-style:=
normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-transform=
:none;white-space:normal;word-spacing:1px;text-decoration:none;background-c=
olor:rgba(0,0,0,0);border-color:rgb(49,49,49);color:rgb(49,49,49)"><span st=
yle=3D"font-size:1rem;background-color:rgba(0,0,0,0);border-color:rgb(49,49=
,49);color:rgb(49,49,49)">warning: arch/arm/boot/compressed/bswapsdi2.o: mi=
ssing .note.GNU-stack section implies executable stack<u style=3D"backgroun=
d-color:rgba(0,0,0,0);border-color:rgb(49,49,49);color:rgb(49,49,49)"></u><=
u style=3D"background-color:rgba(0,0,0,0);border-color:rgb(49,49,49);color:=
rgb(49,49,49)"></u></span></p><p style=3D"font-size:16px;font-style:normal;=
font-weight:400;letter-spacing:normal;text-indent:0px;text-transform:none;w=
hite-space:normal;word-spacing:1px;text-decoration:none;background-color:rg=
ba(0,0,0,0);border-color:rgb(49,49,49);color:rgb(49,49,49)"><span style=3D"=
font-size:1rem;background-color:rgba(0,0,0,0);border-color:rgb(49,49,49);co=
lor:rgb(49,49,49)">NOTE: This behaviour is deprecated and will be removed i=
n a future version of the linker<u style=3D"background-color:rgba(0,0,0,0);=
border-color:rgb(49,49,49);color:rgb(49,49,49)"></u><u style=3D"background-=
color:rgba(0,0,0,0);border-color:rgb(49,49,49);color:rgb(49,49,49)"></u></s=
pan></p><p style=3D"font-size:16px;font-style:normal;font-weight:400;letter=
-spacing:normal;text-indent:0px;text-transform:none;white-space:normal;word=
-spacing:1px;text-decoration:none;background-color:rgba(0,0,0,0);border-col=
or:rgb(49,49,49);color:rgb(49,49,49)"><span style=3D"background-color:rgba(=
0,0,0,0);border-color:rgb(49,49,49);color:rgb(49,49,49)"><u style=3D"backgr=
ound-color:rgba(0,0,0,0);border-color:rgb(49,49,49);color:rgb(49,49,49)"></=
u>=C2=A0<u style=3D"background-color:rgba(0,0,0,0);border-color:rgb(49,49,4=
9);color:rgb(49,49,49)"></u></span></p><p style=3D"font-size:16px;font-styl=
e:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-transfo=
rm:none;white-space:normal;word-spacing:1px;text-decoration:none;margin-bot=
tom:12pt;background-color:rgba(0,0,0,0);border-color:rgb(49,49,49);color:rg=
b(49,49,49)"><span style=3D"font-size:1rem;background-color:rgba(0,0,0,0);b=
order-color:rgb(49,49,49);color:rgb(49,49,49)">warning: arch/arm/boot/compr=
essed/vmlinux has a LOAD segment with RWX permissions<u style=3D"background=
-color:rgba(0,0,0,0);border-color:rgb(49,49,49);color:rgb(49,49,49)"></u><u=
 style=3D"background-color:rgba(0,0,0,0);border-color:rgb(49,49,49);color:r=
gb(49,49,49)"></u></span></p><p style=3D"font-size:16px;font-style:normal;f=
ont-weight:400;letter-spacing:normal;text-indent:0px;text-transform:none;wh=
ite-space:normal;word-spacing:1px;text-decoration:none;background-color:rgb=
a(0,0,0,0);border-color:rgb(49,49,49);color:rgb(49,49,49)"><b style=3D"font=
-size:1rem;background-color:rgba(0,0,0,0);border-color:rgb(49,49,49);color:=
rgb(49,49,49)">Questions:</b><u style=3D"background-color:rgba(0,0,0,0);bor=
der-color:rgb(49,49,49);color:rgb(49,49,49)"></u><u style=3D"background-col=
or:rgba(0,0,0,0);border-color:rgb(49,49,49);color:rgb(49,49,49)"></u></p><o=
l start=3D"1" type=3D"1" style=3D"margin-bottom:0in;font-size:16px;font-sty=
le:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-transf=
orm:none;white-space:normal;word-spacing:1px;text-decoration:none;margin-to=
p:0in;background-color:rgba(0,0,0,0);border-color:rgb(49,49,49);color:rgb(4=
9,49,49)"><li style=3D"background-color:rgba(0,0,0,0);border-color:rgb(49,4=
9,49);color:rgb(49,49,49)"><span style=3D"font-size:1rem;background-color:r=
gba(0,0,0,0);border-color:rgb(49,49,49);color:rgb(49,49,49)">What are the m=
inimum and maximum supported GCC versions for building this CIP kernel?<u s=
tyle=3D"background-color:rgba(0,0,0,0);border-color:rgb(49,49,49);color:rgb=
(49,49,49)"></u><u style=3D"background-color:rgba(0,0,0,0);border-color:rgb=
(49,49,49);color:rgb(49,49,49)"></u></span></li><li style=3D"background-col=
or:rgba(0,0,0,0);border-color:rgb(49,49,49);color:rgb(49,49,49)"><span styl=
e=3D"font-size:1rem;background-color:rgba(0,0,0,0);border-color:rgb(49,49,4=
9);color:rgb(49,49,49)">Is there official documentation specifying the reco=
mmended toolchain versions for Linux CIP 4.4?<u style=3D"background-color:r=
gba(0,0,0,0);border-color:rgb(49,49,49);color:rgb(49,49,49)"></u><u style=
=3D"background-color:rgba(0,0,0,0);border-color:rgb(49,49,49);color:rgb(49,=
49,49)"></u></span></li></ol><p style=3D"font-size:16px;font-style:normal;f=
ont-weight:400;letter-spacing:normal;text-indent:0px;text-transform:none;wh=
ite-space:normal;word-spacing:1px;text-decoration:none;background-color:rgb=
a(0,0,0,0);border-color:rgb(49,49,49);color:rgb(49,49,49)"><span style=3D"b=
ackground-color:rgba(0,0,0,0);border-color:rgb(49,49,49);color:rgb(49,49,49=
)"><u style=3D"background-color:rgba(0,0,0,0);border-color:rgb(49,49,49);co=
lor:rgb(49,49,49)"></u>=C2=A0<u style=3D"background-color:rgba(0,0,0,0);bor=
der-color:rgb(49,49,49);color:rgb(49,49,49)"></u></span></p><p style=3D"fon=
t-style:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-t=
ransform:none;white-space:normal;word-spacing:1px;text-decoration:none;font=
-size:1rem;background-color:rgba(0,0,0,0);border-color:rgb(49,49,49);color:=
rgb(49,49,49)">Best regards,<br>Sohaib Radwan<u style=3D"background-color:r=
gba(0,0,0,0);border-color:rgb(49,49,49);color:rgb(49,49,49)"></u><u style=
=3D"background-color:rgba(0,0,0,0);border-color:rgb(49,49,49);color:rgb(49,=
49,49)"></u></p><br></div>
</div>
</div>
</div></div>

--000000000000686ad6063e9a0267--

