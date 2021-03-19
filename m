Return-Path: <SRS0=fOLG=IR=lists.cip-project.org=bounce+64572+6300+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091A3C433DB
	for <cip-dev@archiver.kernel.org>; Fri, 19 Mar 2021 08:21:08 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D480064DFB
	for <cip-dev@archiver.kernel.org>; Fri, 19 Mar 2021 08:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D480064DFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6300+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 6SsgYY4521723xfNQqiOQc2X; Fri, 19 Mar 2021 01:21:05 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web10.3371.1616142063568469504
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Mar 2021 01:21:05 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 12J8KmdS010001
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Mar 2021 09:20:48 +0100
X-Received: from [167.87.41.130] ([167.87.41.130])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 12J85j2B008075;
	Fri, 19 Mar 2021 09:05:45 +0100
Subject: Re: [cip-dev] [Feedback Requested] RE: Cip-kernel-sec Updates for Week of 2021-03-18
To: masashi.kudo@cybertrust.co.jp, minmin@plathome.co.jp,
        cip-dev@lists.cip-project.org
Cc: pavel@denx.de, nobuhiro1.iwamatsu@toshiba.co.jp, wens@csie.org
References: <TY2PR01MB4972E1E07AE85D162237E83CA0699@TY2PR01MB4972.jpnprd01.prod.outlook.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <d111661c-cdda-3031-66e3-054a5cdcc943@siemens.com>
Date: Fri, 19 Mar 2021 09:05:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <TY2PR01MB4972E1E07AE85D162237E83CA0699@TY2PR01MB4972.jpnprd01.prod.outlook.com>
X-MIME-Autoconverted: from 8bit to quoted-printable by lizzard.sbs.de id 12J8KmdS010001
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: pkYYQCmV3dSNkgZkg9nlvGx8x4520388AA=
Content-Type: multipart/mixed; boundary="PfvZ1NJHreyo1copbIyt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616142065;
 bh=/0DnuEPtohub6BTL8mwT6jXKINe0xQBInUddLsUDuFY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Srv7uoI02kOhZVez2M/Bt63vwmtr94cDE91M8b32pjN7fNAoYbq9Di+Mzdp8T9bGGgi
 yHHjA/UmBpgt9FMRlrwkW3JvTcZ19LZ8rf71aa8xnAi/U4KDe1ayoaIMAfdT+C+Qzac/o
 GY1dxWID/GiuhOBsGxJEXF1VXqkRSQdHfPQ=

--PfvZ1NJHreyo1copbIyt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.03.21 10:33, masashi.kudo@cybertrust.co.jp wrote:
> Hi, Jan-san, Minda-san,
>=20
> Please find the CVE report as follows.
> In the analysis of those CVEs, we found some doubts about the configs.
>=20
> - CVE-2020-35519 is relating to X.25.
> X.25 is enabled as follows, but we wonder whether X.25 is really used o=
r not.
>>     4.4.y-cip/x86/plathome_obsvx1.config:CONFIG_X25=3Dm
>>     4.19.y-cip-rt/x86/siemens_i386-rt.config:CONFIG_X25=3Dm
>>     5.10.y-cip-rt/x86/siemens_i386-rt_defconfig:CONFIG_X25=3Dm
>=20
> Please confirm, and let us know whether X.25 should be disabled.
>=20
> - CVE-2021-20261 is relating to floppy.
> It is enabled as follows.
>>     4.4.y-cip-rt/x86/siemens_i386-rt.config:CONFIG_BLK_DEV_FD=3Dm
>=20
> Please confirm that this can be also disabled.
>=20

Yes, both features can be turned off.

Thanks,
Jan

> Best regards,
> --
> M. Kudo
>=20
>> -----Original Message-----
>> From: Chen-Yu Tsai <wens@csie.org>
>> Sent: Thursday, March 18, 2021 5:48 PM
>> To: cip-dev@lists.cip-project.org
>> Cc: Pavel Machek <pavel@denx.de>; Nobuhiro Iwamatsu
>> <nobuhiro1.iwamatsu@toshiba.co.jp>; =E5=B7=A5=E8=97=A4=E3=80=80=E9=9B=85=
=E5=8F=B8=EF=BC=88CTJ=E3=80=80OSS=E4=BA=8B=E6=A5=AD=E6=8E=A8=E9=80=B2=E5=AE=
=A4=EF=BC=89
>> <masashi.kudo@cybertrust.co.jp>
>> Subject: Cip-kernel-sec Updates for Week of 2021-03-18
>>
>> Hi everyone,
>>
>> Six new issues this week from the Ubuntu tracker:
>>
>> - CVE-2020-35519 [net/x25: buffer overflow] - fixed
>>   Looks like a few configs still have X.25 enabled:
>>     4.4.y-cip/x86/plathome_obsvx1.config:CONFIG_X25=3Dm
>>     4.19.y-cip-rt/x86/siemens_i386-rt.config:CONFIG_X25=3Dm
>>     5.10.y-cip-rt/x86/siemens_i386-rt_defconfig:CONFIG_X25=3Dm
>>   Maybe they should be revisited? cip-kernel-config also gives warning=
s
>>   for CONFIG_X25.
>>
>> - CVE-2021-20219 [improper synchronization in flush_to_ldisc()] - like=
ly RedHat
>> only
>>   Report mentions incorrect backport in RedHat kernels.
>>
>> - CVE-2021-20261 [floppy: race condition data corruption] - fixed
>>   No member enables this except:
>>     4.4.y-cip-rt/x86/siemens_i386-rt.config:CONFIG_BLK_DEV_FD=3Dm
>>   which should probably be turned off.
>>
>> - CVE-2021-28375 [fastrpc: allows sending kernel RPCs] - fixed
>>   No member enables this.
>>
>> - CVE-2021-28660 [rtl8188eu: array access out-of-bounds] - fixed
>>   No member enables this.
>>
>> - CVE-2021-3428 [integer overflow in ext4_es_cache_extent] - unclear [=
1]
>>   Requires a specially-crafted ext4 FS image, so we likely don't care.
>>
>> Unfortunately Debian's Salsa service, where the Debian kernel security=
 issue
>> tracker is hosted, is currently down, so we only have one source of da=
ta this week.
>>
>>
>> Regards
>> ChenYu
>>
>>
>> [1] https://lore.kernel.org/stable/20210317151834.GE2541@quack2.suse.c=
z/


--=20
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--PfvZ1NJHreyo1copbIyt
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6300): https://lists.cip-project.org/g/cip-dev/message=
/6300
Mute This Topic: https://lists.cip-project.org/mt/81425316/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--PfvZ1NJHreyo1copbIyt--
