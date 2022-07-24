Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F15FC43334
	for <webhook@archiver.kernel.org>; Sun, 24 Jul 2022 14:51:51 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.43])
 by mx.groups.io with SMTP id smtpd.web11.17186.1658674309783376671
 for <cip-dev@lists.cip-project.org>;
 Sun, 24 Jul 2022 07:51:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=lR69By/u;
 spf=pass (domain: siemens.com, ip: 40.107.6.43,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTlUul8zbq2M3xnUjFwpaleA9aZyhLJkosZvvRkiJfY2unebXaN9ZGC4lNgtTXkpzYTQ5qGTE3OmJvUh7u5y6gxytrpe0Ryp2t3Tq49HdHwRNSmyhKJP6pcz00kZVj9oNh3AoZD40MDmz/gNcU+0zq80Rv4SFMiphDcerltj0d0Q4NMQcxZodYUSzEuLxVGKWdWuQbvFmk7jL/ji3L1fBfwzF5M+xkOGAAF0YE1kZFfYJJxbRtA2j0SAelfpFrH9mH80IIf5PflR8lLll6a5/C5kBDahjl1rv9yeOCfwRNMFhH78AhtZFmwI3TgSK91uWEoQ3DEJllhM6JK9w91bLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYkO8k4uaL/lezUH54xd3iXPVRkDehd55PXoBXzROHo=;
 b=EOATxSw/DpaRrikLz84LXPUo5zoCQK67JPlC5j7q+6UXYe9X1nf8eidwGKCLKEpaKHZ1d6P7NfmLs+qZ+1rorcimsvabOnP2xqFTu9hP+dkpvU3YmTl3C+uqjtHufdKbgj46A5QVmnD/EWvUMW7T1To4DGQ1pDM5eAG7HkLlesUps3taWLqMvhxI48NlH0nkGTsmCy+DZU3PVKwMCpX2NZXDxB2yjZhZcWhPmxPBQJA6gZBuR0H2gULWWXAvdm/+RG0we/qdMZpyH9qkHrPMVdP7uZeqr6CPcfaNX9PiYVlHDjRuVmlSbnyytfij9mEGoAhizuy8gUAz0fuCZbUcFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYkO8k4uaL/lezUH54xd3iXPVRkDehd55PXoBXzROHo=;
 b=lR69By/uboCQEY6HtjsEt1kG5K7m6Q3OISi7E+HX84y24mBGBgnM3KLpbJQG+23FVxQqPOd8CKajH0pW4mFOpSbX6nKcBxU1u/HnQqNTMy9uvBe7+z9Gufv5qijsWCqAGKdwKYzZl3+lDAikDdUPhNTSCf670BrteZmnxTMaWznmGjrWOVwwfTbMuA/oldd8clUvQXjgd9fMXbLD0mNYGY0gNwF47bhfHwenS8fs/zLpuqkwWuYc2y+6yApgPk6wSEmAvRDCIkA7hqXnmJ+q1y74x2/haFkBXpP1CaLYZbqPGKPIhJlXAsSgvnsdUpIcK6ngu6Z0vuetbRvE/uutTQ==
Received: from DB6PR07CA0065.eurprd07.prod.outlook.com (2603:10a6:6:2a::27) by
 DB7PR10MB2076.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:5:c::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.19; Sun, 24 Jul 2022 14:51:46 +0000
Received: from DB5EUR01FT105.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:6:2a:cafe::45) by DB6PR07CA0065.outlook.office365.com
 (2603:10a6:6:2a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.7 via Frontend
 Transport; Sun, 24 Jul 2022 14:51:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 DB5EUR01FT105.mail.protection.outlook.com (10.152.5.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.17 via Frontend Transport; Sun, 24 Jul 2022 14:51:45 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Sun, 24 Jul 2022 16:51:45 +0200
Received: from [139.22.104.190] (139.22.104.190) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Sun, 24 Jul 2022 16:51:44 +0200
Message-ID: <ef1fa74c-7366-24cb-f2c0-69f9a0e09d4d@siemens.com>
Date: Sun, 24 Jul 2022 16:51:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [isar-cip-core] security-customizations: Fix pam_tally2
 deprecation
Content-Language: en-US
To: <Venkata.Pyla@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
References: <20220721065917.11637-1-venkata.pyla@toshiba-tsip.com>
 <c63a7711-155a-7b0f-2109-1ffc4513954d@siemens.com>
 <OSYPR01MB5542DB553157E82974F75F53A4929@OSYPR01MB5542.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <OSYPR01MB5542DB553157E82974F75F53A4929@OSYPR01MB5542.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [139.22.104.190]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--13.727100-8.000000
X-TMASE-MatchedRID: G9QKf9eUqNAwrKi3eh3JIsb9CgEQmMW5Pg9yfk4YC0bM1jffIgQXhr/k
	INU/9Cx+fhcIM0AFu8BmeCLE2iu14M3aYyig7WDa4xZHvdWTxkxbP2JkpusyJkhwlOfYeSqxM0w
	EwxpnA/5QdwGfvSIlB4ztwqNHTrd/lJXBvk7vV7/OmO2B4NTjSmJZXQNDzktSnFVnNmvv47vr3E
	41VlKsfaU8P1uqZC0fRJkeffO0FU/M2Whpw0fI0OQEkglipGR3xkykQYhw2qF5zXLXCu83xcU1M
	FPT0aViIFBEE5CFomLtLC7lY9HoTisfjraA7EML9cn2kV2xUSChqGDU6KwoEA9alxRrc4fRAvbf
	sVXdciRXPwnnY5XL5G4ONy/oUHBddv3Gh5XGj9o0FtU0ovNWcsfdkIlEiI2kEXjPIvKd74AujMj
	6uE1hubbMVaqtU3gFXjesFOd0pM7nzlXMYw4XMAGLeSok4rrZC24oEZ6SpSkgbhiVsIMQK9LdHH
	LXgng308+Vxu9tz8N+u6SAB2noofO+nDFF63wAsLoOUGETcCNYKVgm72vjJg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.727100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 2A5B9520F44D0301A45178A93B6920781C3BECD030D46234A38A4615E895438D2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 873c04a9-d4b5-4b28-57e0-08da6d840786
X-MS-TrafficTypeDiagnostic: DB7PR10MB2076:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jaOVjILLDFpwWisrBpVynaYbMlI8o7hk1H/z4gEnk0t5cFFBTCwx0KIx5Qer8TrkKgzbUa+dWWmejDMRE/eS+aW+zdeHwSiv+zvvBguR5Zw9by//3+246+SARHJydQBCXQYuArlND3bZa4m5HSPEFSn5CT7niT4hFkTsHWkG3pjjiUUyVDhvYs3x9Vto0bPA9/BPSB4BUVTRkFA98ItpKoxPM8jtXrrRo7pXhINhDC5j5BLkmWq86R1X165m3X1CCA+59QbjgMychaX0g35sDhGmehCSpIKCG+dcQCRHSf8ryQEOtOY6gCulPtiJppuj3IRekS+OxRW7bNe6OX5Iil1fWTNI3BgtA4mHpK2yMVEBRDX3xc3d5o0G9bO22t4iwB42jyPZDtloOk8XRPIRDdYMx/6ULtPn+ACEtGTiQgUnT5qwxWElAnxOMLoIw/79tmOYj3LUnVtlb6254aLOZ9eviPnGLQaPEF6o5KRFOgv8kceU1VlanOpK1pqzxK+5nKVrTvDdqhPdrd2+cXpZF9htSNGKaDP5CmRyFaPnJ4McP57fjwmRd+g9oSDjmdeluOO7wH77Ja0E0hHlf2flLXz9lxOaly7bGTCXQkaCsH48OCsYd61UaIt1sfeZgkgT9yVkrf6Csdxzb6Kbr74dbooiUxH4G3EqYJZWg17XorZowY1fg4FNjT2dix99FpJ+wh6FNts1vQvmx/b1FSYIs76K/Zk/kY9/AmvSOt1+kQGZjSSWJ8ABUeZUjGF3Qc+gyuB+XR1GzZTiHiMohPxirJDL9VE4TQeN7Fbh/Dtl8FsK965eTSoADXOSj6UzVUiYFArNUT01HjDwFHTZZcRR31jQNKx7OSF4dQi74r/z5R9s9sREx/HJjbyzd5OXsEVTn+ThBuXs8LUZLwWt+bhpinZdNFlZBqQEYR8CtTYdS24=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966006)(36840700001)(40470700004)(36756003)(40460700003)(316002)(54906003)(966005)(478600001)(110136005)(16576012)(6706004)(2616005)(41300700001)(26005)(8676002)(36860700001)(82960400001)(15650500001)(82740400003)(956004)(31686004)(2906002)(53546011)(186003)(83380400001)(82310400005)(356005)(5660300002)(16526019)(44832011)(86362001)(40480700001)(4326008)(81166007)(70586007)(70206006)(47076005)(336012)(31696002)(8936002)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2022 14:51:45.4920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 873c04a9-d4b5-4b28-57e0-08da6d840786
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT105.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2076
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 24 Jul 2022 14:51:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8897

On 24.07.22 07:40, Venkata.Pyla@toshiba-tsip.com wrote:
>=20
>=20
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: 23 July 2022 22:54
>> To: pyla venkata(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting)=
 <Venkata.Pyla@toshiba-
>> tsip.com>; cip-dev@lists.cip-project.org
>> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting)=
 <dinesh.kumar@toshiba-
>> tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =E2=96=A1=EF=BC=
=B3=EF=BC=B7=EF=BC=A3=E2=97=AF=EF=BC=A1=EF=BC=A3=EF=BC=B4)
>> <kazuhiro3.hayashi@toshiba.co.jp>
>> Subject: Re: [isar-cip-core] security-customizations: Fix pam_tally2 dep=
recation
>>
>> On 21.07.22 08:59, venkata.pyla@toshiba-tsip.com wrote:
>>> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>>
>>> pam_tally2 is deprecated from PAM version 1.4.0 that is from Debian
>>> Bullseye, and introduced pam_faillock as replacement [1].
>>>
>>> Modified the security customizations to check first pam_tally2
>>> existence for backward compatibility and if not found use the
>>> pam_faillock to achieve the same functionality.
>>>
>>> Fixes #33
>>>
>>> [1] https://github.com/linux-pam/linux-pam/releases/tag/v1.4.0
>>>
>>> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>> ---
>>>  .../security-customizations/files/postinst    | 19 +++++++++++++++----
>>>  1 file changed, 15 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/recipes-core/security-customizations/files/postinst
>>> b/recipes-core/security-customizations/files/postinst
>>> index 9ba8540..ae06ab7 100644
>>> --- a/recipes-core/security-customizations/files/postinst
>>> +++ b/recipes-core/security-customizations/files/postinst
>>> @@ -22,11 +22,22 @@ sed -i
>>> "0,/^password.*/s/^password.*/${pam_cracklib_config}\n&/"
>>> "${PAM_PWD_FILE  # CR1.11: Unsuccessful login attempts  # Lock user
>>> account after unsuccessful login attempts
>> PAM_AUTH_FILE=3D"/etc/pam.d/common-auth"
>>> -pam_tally=3D"auth   required  pam_tally2.so  deny=3D3 even_deny_root
>> unlock_time=3D60 root_unlock_time=3D60"
>>> -if grep -c "pam_tally2.so" "${PAM_AUTH_FILE}";then
>>> -        sed -i '/pam_tally2/ s/^#*/#/'  "${PAM_AUTH_FILE}"
>>> +# pam_tally2 is deprecated from pam version 1.4.0-7 if [ -f
>>> +/lib/*-linux-gnu*/security/pam_tally2.so ]; then
>>> +       PAM_MODULE=3D"pam_tally2.so"
>>> +       PAM_CONFIG=3D"auth   required  pam_tally2.so  deny=3D3 even_den=
y_root
>> unlock_time=3D60 root_unlock_time=3D60"
>>> +elif [ -f /lib/*-linux-gnu*/security/pam_faillock.so ]; then
>>> +       PAM_MODULE=3D"pam_faillock.so"
>>> +       PAM_CONFIG=3D"auth   required  pam_faillock.so preauth silent  =
deny=3D3
>> even_deny_root unlock_time=3D60 root_unlock_time=3D60 \
>>> +               \nauth   required  pam_faillock.so .so authfail deny=3D=
3
>> even_deny_root unlock_time=3D60 root_unlock_time=3D60"
>>> +else
>>> +       echo "No suitable pam module found to lock failed login attempt=
s"
>>
>> Shouldn't we rather fail (exit 1) in this case?
> I tried not to fail in the middle of applying security configurations,
> rather giving warning to the user and one can check later why this config=
uration is not applied.
>=20

Will that not make it hard to track regressions? Keep in mind that we
generally have no interactive users here, rather automated imaging
steps. Inside Isar, this message will not be shown to anyway but a log
file no one looks at when the installation succeeds.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux

