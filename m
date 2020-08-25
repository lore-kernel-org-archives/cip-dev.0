Return-Path: <SRS0=6JqB=CD=lists.cip-project.org=bounce+64572+5239+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E762CC433DF
	for <cip-dev@archiver.kernel.org>; Tue, 25 Aug 2020 05:59:24 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 753742071E
	for <cip-dev@archiver.kernel.org>; Tue, 25 Aug 2020 05:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="usrhMP0n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753742071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5239+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id J62YYY4521723xaq9fUXaU8T; Mon, 24 Aug 2020 22:59:24 -0700
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web10.8229.1598335161865133340
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Aug 2020 22:59:23 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 07P5xJEG004097
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2020 07:59:19 +0200
X-Received: from [167.87.131.58] ([167.87.131.58])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07P5xHw0002818;
	Tue, 25 Aug 2020 07:59:18 +0200
Subject: Re: [cip-dev] [isar-cip-core][PATCH 1/2] ci: Rewrite using extends
To: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
References: <20200820082434.1302460-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <4f1fd7b8-4fc0-714b-8205-e6a6b93929d8@siemens.com>
 <997dba20-23b6-a170-6a89-b6a894b13e69@siemens.com>
 <OSBPR01MB2983B674E98AC8D3B5B960E092570@OSBPR01MB2983.jpnprd01.prod.outlook.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <77b391e2-3438-88dd-3df6-b9d8e9c37420@siemens.com>
Date: Tue, 25 Aug 2020 07:59:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB2983B674E98AC8D3B5B960E092570@OSBPR01MB2983.jpnprd01.prod.outlook.com>
X-MIME-Autoconverted: from 8bit to quoted-printable by thoth.sbs.de id 07P5xJEG004097
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: io3FFLrpEl2G4GqamDSIH6BIx4520388AA=
Content-Type: multipart/mixed; boundary="LpbwBYgatGzlZGgX1rKn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598335164;
 bh=dH0t5Q4i6CSKCy3g34iEVuPEryZElkvMUz8fwl4EBw4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=usrhMP0nR0UcPynIh33AgJkf6sWMYJ4U1OfFNCnOZK71Pq55mRs1D43E0RL1i2gnkfk
 uNwKEnsukEPBWlaQvNbpVCvNQ0Vwv3LVFzjoxiUAgoD2oJ6VbwkoNfVx4bxNNJuRR4o20
 sawjw7GqzCNsxaVm9xbwdmeaKKmRVeQ4Myc=

--LpbwBYgatGzlZGgX1rKn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.08.20 07:33, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
> Hi,
>=20
>> -----Original Message-----
>> From: Jan Kiszka [mailto:jan.kiszka@siemens.com]
>> Sent: Saturday, August 22, 2020 1:45 AM
>> To: iwamatsu nobuhiro(=E5=B2=A9=E6=9D=BE =E4=BF=A1=E6=B4=8B =E2=96=A1=EF=
=BC=B3=EF=BC=B7=EF=BC=A3=E2=97=AF=EF=BC=A1=EF=BC=A3=EF=BC=B4) <nobuhiro1.=
iwamatsu@toshiba.co.jp>; cip-dev@lists.cip-project.org
>> Subject: Re: [isar-cip-core][PATCH 1/2] ci: Rewrite using extends
>>
>> On 21.08.20 17:04, Jan Kiszka wrote:
>>> On 20.08.20 10:24, Nobuhiro Iwamatsu wrote:
>>>> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>>>> ---
>>>>  .gitlab-ci.yml             | 70 +++++++++++++++++++++++++++++------=
---
>>>>  scripts/deploy-cip-core.sh |  8 +++--
>>>>  2 files changed, 60 insertions(+), 18 deletions(-)
>=20
> <snip>
>=20
>>>> -if [ -n "$DTB" ]; then
>>>> +if [ "$DTB" !=3D "none" ]; then
>>>>  	aws s3 cp --no-progress
>> build/tmp/work/cip-core-*/linux-cip*/*/linux-cip-*/debian/linux-image-=
cip*/usr/lib/linux-image-*/$DTB
>> s3://download.cip-project.org/cip-core/$TARGET/
>>>>  fi
>>>>
>>>
>>> Unfortunately, this scale out to multiple jobs seem to cause download
>>> issues, see e.g.
>>>
>>> - https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/697844=
276
>>> - https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/696946=
649
>>>
>>> First thought it was a sporadic hic-up, but it reoccurs, now with
>>> master. Is kernel.org throttling us here?
>>>
>=20
> This may be a burden on kernel.org as snapshot reconstructs the image
> on the server side. I'm not sure, when downloading images continuously,
> access may be controlled by kernel.org.
>=20

So we need to avoid that for now, I guess. Back to single-job build, or
do we have an alternative download source?

>>
>> And I'm afraid there is more broken, namely in the deployment that is
>> only triggered over master. Please have a look at the failing jobs.
>=20
> I don't have no idea about this.
> If we retry the test, it is successful and there may be other causes.
>=20

The wic image names changed, and that broke compression and uploading.

Jan

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--LpbwBYgatGzlZGgX1rKn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5239): https://lists.cip-project.org/g/cip-dev/message=
/5239
Mute This Topic: https://lists.cip-project.org/mt/76304024/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--LpbwBYgatGzlZGgX1rKn--
