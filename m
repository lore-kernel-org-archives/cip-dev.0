Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7267C3DA7F
	for <webhook@archiver.kernel.org>; Wed, 31 Jul 2024 18:02:30 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by mx.groups.io with SMTP id smtpd.web10.48037.1722445279333372171
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Jul 2024 10:01:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=jan.kiszka@web.de header.s=s29768273 header.b=jY/EArp3;
 spf=pass (domain: web.de, ip: 212.227.15.3, mailfrom: jan.kiszka@web.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722445277; x=1723050077; i=jan.kiszka@web.de;
	bh=HikiMLiFOWpvP/WQTeHcaqnQmcBAb23026wyj+sPECM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jY/EArp3b91EsXt97Iumj2OfXJy+r44MSUJGHjGC1KGuWy+jAjA7fe9BL5sk7CU3
	 S3jGXTDwrYcV+gmO0NyP4rMWmhFbMuce8/A8bEZ+Tlkjd73eqI+uXs2iRAS0Sr0Sw
	 WVES1z6AGxcfmBuOwQtGpoepgyZS56ITQdhoTlfSXiRtJgfLFpmJTQSolSjH453zA
	 GJLW9lWc2NUlYNTcAa3gRNtrnDIPa7z5QJlqzAjwx1PvX4nzrYvb/FGbU0YQxLGHJ
	 JqR7V5gcUDdNL8+PcfnU+hWxMbkUZ3AOSQ3RWCjRWBXFZwfvhCg1DaMeW+6lwKhRX
	 jgi/ovAqogTkPmyqDQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.31] ([82.83.168.54]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7gXO-1sChyR03zW-012GnS; Wed, 31
 Jul 2024 19:01:17 +0200
Message-ID: <12d8317a-9510-431b-b24a-9175192e6378@web.de>
Date: Wed, 31 Jul 2024 19:01:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] [PATCH v2] classes/squashfs.bbclass: exclude boot dir for efibootguard bootloader
To: srinuvasan.a@siemens.com, cip-dev@lists.cip-project.org
Cc: felix.moessbauer@siemens.com
References: <284ef2098da5aaeff02a565c4316fff854add437.camel@siemens.com>
 <20240723100631.75683-1-srinuvasan.a@siemens.com>
From: Jan Kiszka <jan.kiszka@web.de>
Autocrypt: addr=jan.kiszka@web.de; keydata=
 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
In-Reply-To: <20240723100631.75683-1-srinuvasan.a@siemens.com>
X-Provags-ID: V03:K1:TKNlpoHan6x7nouydDkCnbJBYemq8GXapaWf/hTPHmkBkB2eztV
 +dofMlpUqt7lX0GNovhc2p7sLR+lrJXYUeZD+Tp64VvCYL3pqtx7ESE8nNKNAw4v6J8gog8
 Bo3fjXZIC8ONGDPb45kRKZ97zrY8lU7GoNOWoy4Wi+Hx2+ZDyvoEfDNNH/xiQYeb0HpNH0F
 3RbuTRM8pAtyAPB7eY8dg==
UI-OutboundReport: notjunk:1;M01:P0:Eb+WixM9dkA=;DlBlNpel1tETqXw75xNgXs8Q8sF
 E97fMlU/bVrM/UY7j0qbuy72VVF847DTbI9qU0wq06eeIGlI49WAJ6StYRtMTUM0Aq1lhiIN4
 6i6mKwSbDd44S7mLff0Cnrw4RhFyUp+K2s1qem0CxQ3UJAsaK4w1ZifbOZpClW9pLXMp6egSt
 390VAdjxGqGfwVhaBHLaQNzlTYc4y+6eMynTx5svosDeUBPeJRWyngSO85ivz0Gy8iHb27G+9
 SrhBNJdhA2MnmGQlv3uCev5YFOfeUeZrSqyOMKLqIduJWZRzO2F1fE8b/K2kCVqM1+SMA8Rsu
 pagG7Jp5gpIa1S24x/qES/xtWcGuprSSux0M+KK92uP3S3bk0aoRzElAcXCpQkKtme5+Cc3o3
 5QYONGcpm4ujpZ2/UKy9WhzK3qFtdGo5ifWr0zrJBIciE8b0gYSg3C59IXfGT5Qwp0wGLA3bq
 Ms5Hc0ffIRb8aPztkwMJANKhgQE+rLZ5JJS/ABykkEirdwYW6218SIEcIHPjYqGVuxTsM84oK
 qPD04uegD3kDgFO/tU80soFDG/HfOA3NP6saJt3WvgksHWl+qpNHLLJAcjHmF0Aj2TGSDYS8W
 Zpl7TZIgNBu/c7sm9+Xw8AXfNJe7YWYoHMQN7LaEPduqIdbam3FD1CKu15YUNqXIAXWML9x1G
 IN+/CV6nkDGPHzZoimcwiIDViY4ASoMJbGm6j2DnaCw7LMY9jzkj6lQ7TKWQ74xvRTNGrUTlO
 Nbc0K7Bwt2uFF+iUUOvEObRf4nUnxvxey/+DPRrIgZPh7btkswFYir2iR09FBFbisihipPG9R
 v4kPh1VOkCyIObxMofYUlzIA==
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Jul 2024 18:02:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16697

On 23.07.24 12:06, srinuvasan.a@siemens.com wrote:
> From: srinuvasan <srinuvasan.a@siemens.com>
>
> efibootguard based bootloader boot the system using linux.efi (UKI) and =
it has
> the necessary boot files to boot the system, hence we added boot dir as =
the exclude dir
> in squashfs root file system to remove the contents from the boot dir.
>
> Signed-off-by: srinuvasan <srinuvasan.a@siemens.com>
> ---
>  classes/squashfs.bbclass | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/classes/squashfs.bbclass b/classes/squashfs.bbclass
> index b39be0c..2582ce2 100644
> --- a/classes/squashfs.bbclass
> +++ b/classes/squashfs.bbclass
> @@ -23,6 +23,7 @@ def get_free_mem():
>  IMAGER_INSTALL:squashfs +=3D "squashfs-tools"
>
>  SQUASHFS_EXCLUDE_DIRS ?=3D ""
> +SQUASHFS_EXCLUDE_DIRS_EFI ?=3D "boot"
>  SQUASHFS_CONTENT ?=3D "${PP_ROOTFS}"
>  SQUASHFS_CREATION_ARGS ?=3D ""
>
> @@ -31,6 +32,8 @@ SQUASHFS_MEMLIMIT ?=3D "${@int(get_free_mem() * 3/4)}"
>  SQUASHFS_CREATION_LIMITS =3D "-mem ${SQUASHFS_MEMLIMIT} -processors ${S=
QUASHFS_THREADS}"
>
>  python __anonymous() {
> +    if (d.getVar('SWUPDATE_BOOTLOADER') =3D=3D 'efibootguard'):
> +        d.setVar('SQUASHFS_EXCLUDE_DIRS', '${SQUASHFS_EXCLUDE_DIRS_EFI}=
')

I still don't get why we should carry this knowledge here. It is also
mixing up "EFI" with "efibootguard" - there is no efibootguard without
EFI, but the other way around is possible.

And then it is the image recipe or - even closer - the wks file that
brings it all together, the fact that squashfs is used for rootfs (and
only for that?!?), that there is some boot folder that is not needed twice=
.

Jan

>      exclude_directories =3D d.getVar('SQUASHFS_EXCLUDE_DIRS').split()
>      if len(exclude_directories) =3D=3D 0:
>          return


