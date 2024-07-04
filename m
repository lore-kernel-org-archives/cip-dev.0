Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A43CC38150
	for <webhook@archiver.kernel.org>; Thu,  4 Jul 2024 13:29:37 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web10.10227.1720099770456333087
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Jul 2024 06:29:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@denx.de header.s=phobos-20191101 header.b=NTSxVdvu;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: ch@denx.de)
Received: from [10.0.200.95] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: ch@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 62DB78867A;
	Thu,  4 Jul 2024 15:29:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720099768;
	bh=DhihECRICpkdV7HwMNCneBacT5NSKkatXKgSJtYNhdc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=NTSxVdvuMLrkZMban5qvREU3p1cDfS7quA6jO+fpPRDK9DXOIypkOz/Q2m5NOQx2T
	 jvj+7Szsf+ktRs22ld7fMVrKlFwMiZdaGfz+G2tisQsK7nps66G8UvH+PxBK1RaGs3
	 tSwHW6gY2t6K4a7r1np287um7BEk0pWpo4hjK6tc7rCiUSovpXaK40ZjSRccoDS4aK
	 +B5LwVrbTJZYhG3GFt6wU1Wf3700EvEyR0CW77MaN8hhOp9uNvd4Q/gO2jQwttU3vU
	 OAwzJuZke9r1T1qUwqD2k5zBlVQZA2dNpCLCR+AhqGNbpg1icXwHkNk6tBLWg+wOSZ
	 KQw5gEovdMSXA==
Message-ID: <204be939-3a9e-4210-9194-a70ac83640da@denx.de>
Date: Thu, 4 Jul 2024 15:29:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] swupdate.bbclass: make swu_files entries unique
To: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20240703114242.1896508-1-ch@denx.de>
 <7a7ed1e59a5682144aaaad819fbbd1264f3ece34.camel@siemens.com>
Content-Language: en-US
From: Claudius Heine <ch@denx.de>
Organization: Denx Software Engineering
In-Reply-To: <7a7ed1e59a5682144aaaad819fbbd1264f3ece34.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Jul 2024 13:29:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16374

Hi Felix,

On 2024-07-04 2:15 pm, MOESSBAUER, Felix wrote:
> On Wed, 2024-07-03 at 13:42 +0200, Claudius Heine wrote:
>> In case a sw-description contains multiple entries of the same file,
>> swu_files will contains multiples of the same file and thus later
>> operations fail.
>=20
> Hi, I'm wondering how that can happen, but OK.

How it happens that there are multiple mentions of the same file in a=20
sw-description, or how it happens that it fails?

Multiple instances of the same file happens when the swupdate software=20
collections are used to implement A/B update:=20
https://sbabic.github.io/swupdate/sw-description.html#software-collection=
s

There the same image can be flashed to different devices.

The build fails on the `ln -s` just a couple of lines later in that=20
file, since `--force` isn't used, the symlink will already exist on the=20
second mention of that file.

>=20
>>
>> This change makes the files in the swu_files variable unique, so they
>> are only operated on once.
>>
>> Signed-off-by: Claudius Heine <ch@denx.de>
>> ---
>>  =C2=A0classes/swupdate.bbclass | 2 +-
>>  =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
>> index e91238d..5e54853 100644
>> --- a/classes/swupdate.bbclass
>> +++ b/classes/swupdate.bbclass
>> @@ -205,7 +205,7 @@ IMAGE_CMD:swu() {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swu_file_base=3D$(ba=
sename $swu_file)
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Create symlinks fo=
r files used in the update image
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swu_files=3D$(awk '$=
1=3D=3D"filename"{gsub(/[",;]/, "", $3); print
>> $3}' \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "$=
{WORKDIR}/$swu_file_base/${SWU_DESCRIPTION_FILE}")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "$=
{WORKDIR}/$swu_file_base/${SWU_DESCRIPTION_FILE}" |
>> sort | uniq)
>=20
> By that, we also change the order of the files in the swu. Are we sure
> that there are no unwanted side effects?

Hmm... this is a interesting point, it might be the case for streaming=20
update files, I will check that.

regards,
Claudius

>=20
> Felix
>=20
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 export swu_files
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for file in $swu_fil=
es; do
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if [ -e "${WORKDIR}/$file" ]; then
>=20

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-54 Fax: (+49)-8142-66989-80 Email: ch@denx.de

