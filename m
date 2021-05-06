Return-Path: <SRS0=YJvR=KB=lists.cip-project.org=bounce+64572+6436+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B53C433ED
	for <cip-dev@archiver.kernel.org>; Thu,  6 May 2021 14:56:47 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA5EC610CE
	for <cip-dev@archiver.kernel.org>; Thu,  6 May 2021 14:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5EC610CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6436+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 8CF0YY4521723x7eghIKj4Nk; Thu, 06 May 2021 07:56:46 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web11.507.1620312995239400299
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 May 2021 07:56:36 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 146EuWvc001148
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 6 May 2021 16:56:33 +0200
X-Received: from [139.22.41.52] ([139.22.41.52])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 146EqsSW007289;
	Thu, 6 May 2021 16:52:55 +0200
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 0/2] swupdate-config: variables cleanup
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20210505082158.18899-1-Quirin.Gylstorff@siemens.com>
 <570b4004-2127-cc30-3970-274731b325e4@siemens.com>
 <1dc8dbe6-6464-148e-6a70-9f797a76af06@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <cbda6d07-13e8-2b82-72ec-af3eb3c96a22@siemens.com>
Date: Thu, 6 May 2021 16:52:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <1dc8dbe6-6464-148e-6a70-9f797a76af06@siemens.com>
X-MIME-Autoconverted: from 8bit to quoted-printable by gecko.sbs.de id 146EuWvc001148
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: F37ZnygzbZ4p3Yvp2ZjBYvK1x4520388AA=
Content-Type: multipart/mixed; boundary="2Zy1BEZCu0VFnKTMiKVC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620313006;
 bh=kmGh27M5IABS+sHYIs+4QAHszKL0lvv1X2o8yZKK8cU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=q+gfTTgTGNPHKIlCjmMqSw4KnJ67G5MpYyFqE5nmtRJENS78y9KBM4I9RW+gTdS5ofu
 sChKLrBpRekR0KOp5tAqZ1pjAWkdEvHFhTurx06KqLo8XC9VXZQmDm/74ejTGOoHRQJ6/
 4o/JkVEOUVf8lMpxAcgs16GrvRrQ3gx6xjQ=

--2Zy1BEZCu0VFnKTMiKVC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.05.21 16:12, Gylstorff Quirin wrote:
>=20
>=20
> On 5/5/21 6:43 PM, Jan Kiszka wrote:
>> On 05.05.21 10:21, Q. Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> This patch removes the variable U_BOOT from the swupdate-config.bbcla=
ss.
>>> It also adds the suffix `SWUPDATE` to the variable BOOTLOADER.
>>>
>>> If a custom u-boot is used in concunction with swupdate it is
>>> recommened to set `U_BOOT_CONFIG_PACKAGE` to '1'. This now adds
>>> a dependency from SWupdate to u-boot-{MACHINE}-config for installing
>>> fw_env.config.
>>>
>>> Changes in V2:
>>> =C2=A0 - fix typo in commit message
>>> =C2=A0 - use variable in kas/opt/*.yml
>>>
>>> Changes in V3:
>>> =C2=A0 - remove variable U_BOOT
>>> =C2=A0 - split into 2 commits
>>>
>>> Changes in V4:
>>> =C2=A0 - Add missing Changes log
>>> =C2=A0 - Correct commit message
>>>
>>> Quirin Gylstorff (2):
>>> =C2=A0=C2=A0 swupdate-config: remove variable U_BOOT
>>> =C2=A0=C2=A0 swupdate-config: add prefix to variable BOOTLOADER
>>>
>>> =C2=A0 classes/swupdate-config.bbclass=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 17 ++++++++++-------
>>> =C2=A0 kas/opt/ebg-secure-boot-snakeoil.yml |=C2=A0 2 +-
>>> =C2=A0 kas/opt/ebg-swu.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
>>> =C2=A0 kas/opt/qemu-swupdate.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>> =C2=A0 4 files changed, 14 insertions(+), 11 deletions(-)
>>>
>>
>> Thanks, applied to next.
>>
>> We may eventually also want to do a renaming of qemu-swupdate.yml to
>> qemu-amd64-swupdate.yml - just for the case that there will also be AR=
M
>> qemu target to demonstrate/test swupdate.
>=20
> Alternative would be to change
> `
> -WKS_FILE =3D "qemu-amd64-${SWUPDATE_BOOTLOADER}.wks"
> +WKS_FILE =3D "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
> `

Right, that file is only an option file anyway.

Jan

--=20
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--2Zy1BEZCu0VFnKTMiKVC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6436): https://lists.cip-project.org/g/cip-dev/message=
/6436
Mute This Topic: https://lists.cip-project.org/mt/82599604/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--2Zy1BEZCu0VFnKTMiKVC--
