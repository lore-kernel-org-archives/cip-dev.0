Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3BBC43334
	for <webhook@archiver.kernel.org>; Mon, 27 Jun 2022 13:04:58 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.56])
 by mx.groups.io with SMTP id smtpd.web08.42100.1656335089504577565
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jun 2022 06:04:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=ebaTBlBf;
 spf=pass (domain: siemens.com, ip: 40.107.20.56,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bp3A10KdEu08Gt06ZbZGP6ffeS0BgkWRDlr1lnL6+ZEgYLU60LQHNT1SVvegX4tj2tuBERjG/PYK4zXMacl4rvZ9nszk9FZsvA6upiZ+AWARmPhgqepQbaUu5nF0QDetyDrTobavEkQ5UVzZFGaQQNZi3y4vfZk18gScRVu3oxl+iAuSoKADhh7v9Lg5ECZO2c9vRfTOh4sZzpowoXox2aIqa8J1UJMyzB1jWkrvvfotb5n+NJqFOwesJYWnSLmWB1QMT7v3cecOOIWlu9ODKqA12hSGFBikBPAmYHoxNjdY6dankLLkduG7C6KRPFABaLIyvYV4uvWKyKZufLyB2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lWUyXfUbPjkYtW5wKXTcOneWGldcDX9s+1brGDbgEI=;
 b=Mbh8zp3TmoirIxrdFNaet8/VmH8xUC9sD8LXJl9/W/uB4/LgjcegqJTIZzHcYnnJbixW19qIXAFUy7nyW4iQQ55x4fMZQXLbGme4sYeDfTTUd9vdlZ+JXCiCZAKD6Aopst5xyel5onN8S54+M84r+o/6rcn3/ylcbvgKocnwALoYdmgTX4At4gUZIM0BMyJg0y2mcsAUHQGKjv6y9Z88h1dFCSMhR0zIvRoHM5rsV9RTrnCXfG4NgVsv8m1mguLU3AoG024HTlwofWvtvFl7L8dS+dQzQDOstr3+XuM8NBpIAyywDw991x0Ro1ySYVX9Dhery4fLT34YpfLXo6WEvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=mentor.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lWUyXfUbPjkYtW5wKXTcOneWGldcDX9s+1brGDbgEI=;
 b=ebaTBlBfqXze9wbxaDYJ1MK9apR+oFxFCfYuT2eRaMumASRjSmeXnkii2MLCjobY8/LqryHuVOU65kmzy/GlcDMSrqhd28Ag1W2hPGB3slMCUuW1GJQ7m/Vkkwt7+XAAjDhdVKyrYEt+8f1FENGgpyENORzNGuHuSHTDp1rqwLA+ZvCT+AVACxD0K590w+OgxITaAlDXnlXTTFmR/WJWRU1hb1F+ov6VqwljSVcHGbsZ7qOkDjKdu0CppSakECsDaXJC9ySafnemJejyBJ0pVtB6oNCBIprYuKIx5OP4u1OLJd9Y74RxL4B2h04qhURtLflGssC6mrly9kBqoKJQBA==
Received: from OL1P279CA0052.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:14::21)
 by AM9PR10MB4103.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Mon, 27 Jun
 2022 13:04:46 +0000
Received: from HE1EUR01FT093.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:14:cafe::bb) by OL1P279CA0052.outlook.office365.com
 (2603:10a6:e10:14::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Mon, 27 Jun 2022 13:04:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 HE1EUR01FT093.mail.protection.outlook.com (10.152.0.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.15 via Frontend Transport; Mon, 27 Jun 2022 13:04:45 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 27 Jun 2022 15:04:44 +0200
Received: from [139.22.133.104] (139.22.133.104) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 27 Jun 2022 15:04:44 +0200
Message-ID: <2a7a1722-6a20-4694-0d79-c2219a9537d4@siemens.com>
Date: Mon, 27 Jun 2022 15:04:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [cip-dev] [isar-cip-core] [PATCH] scripts/start-efishell.sh: Add
 -nographic option
Content-Language: en-US
To: "Kanagarajan, Vijaikumar" <Vijaikumar_Kanagarajan@mentor.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Gylstorff
 Quirin" <quirin.gylstorff@siemens.com>, "P T, Sarath" <Sarath_PT@mentor.com>
References: <20220627071206.21277-1-Sarath_PT@mentor.com>
 <665fa99b-7ab0-1b8c-3662-c1f1ad7a8d4c@siemens.com>
 <95a32358-94ab-d9c3-c0ac-df0258e2bacb@siemens.com>
 <fef66432-ac36-9e2d-7813-5e123d919bbf@siemens.com>
 <e932eb87b7564592bacdc82aa1fae449@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <e932eb87b7564592bacdc82aa1fae449@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [139.22.133.104]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--21.056800-8.000000
X-TMASE-MatchedRID: XYZjbEcsSe7rOhfRe676RwJfVW3wuXXEPg9yfk4YC0bM1jffIgQXhltX
	gpRlmDco4TKzelTQRYFyeLPMYZH47lU2hnXQ06tjcW1NqkTA1zuwuY2Omyci17SlePUaQB97y73
	3NwuklsIObqrib5a4Wjq01dabe8li0+LXQD2NwNIlfWgB3lwUOnislZT0wWWC5Qo03mEdwAGWOD
	D/yzpvdwdkFovAReUoaUXs6FguVy06iroqdaj+4/9Z+RevK1F4XcRIPohGlepuXgIqq6mQyvRU+
	9PTPHSYp+5vzsY5mKPw/uiEDEcVOefOVcxjDhcwAYt5KiTiutnueL4ZNRL7EcRB0bsfrpPIqxB3
	2o9eGcn/ita+mP1RyBzdwtKMMHS+F9cWKQcsuoQaORkTemFZoTSmybT89kBKT+EO5+wLU+s=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--21.056800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 5ECFA64D170637E2E3F3ADE808E4BB68634A37D01A5B59A780B6B11AA10B1DC12000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bd9286f-8536-4942-22e9-08da583d9b82
X-MS-TrafficTypeDiagnostic: AM9PR10MB4103:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mnkCaUyr8aTk/FvdlWEXtbpoRir4/rr7wyfF8KO/qKCY0PtZN/TrQHeBA+w/ElV3AZgJfOEz6tFMljPQwcFir1RXSjWNzj0hXev/dkcGlrt1m6AOJ76zmcuYirat2G1g+2zWh3SCrpl0vFXum3hhLS/ub0FoFy+xNu29Jx95k1c16dKpJOau+KjxYis79HHZMEwa5k5NYK9jpXBpDNda6/C2NBzkegUxj3zh9E4MM1gh44R1644lL1dbs7M4pcJwYIE9/LhTVEH0HxwtNhPOyrTCjLEkW844bqOtG3xODV9S3+p9hF25woYRjqbC4m2OQyN782mreXJM0NCGq/dFOrY/Tli1qZEhbWsFQjZvP5aSiscvgt9z+oWIXPN4G7rueUiQQPmNyaC02HiU5mfI+WgCectDsRvbo4yFiMTt2ICzqf4cX6Q3+psYxjPsWedUU5nMbMKh8iwOTZGstValMmczhJxBRNUgoq6suIIrNMS3eHCgJVX2k3TFyERTeyxuX1c+ECFJo2r+yFgfBBzVvtv7UlaAUamOpeYzZN6HHSDzhSqjkYnw/rhcIOxsfgcZHmRGnqHJaSyn0kANSsZj1uQ/T8nFmWd8gwaA509YM+lDJ0pYJGqno5Ko0SvnkjUaatmaO/Ni+GeXT1GdeHtf/hySOkbF+AbIyQ6Od0oyWfz1Ut9qwtkHmq2CBmiSclAXO8qiFzSBnaLMCkVB+y33nEldLdWqO8Fg3TygfSptpKeGLe32oDiAQUEo1Xq12jiDXUazFaNOsJTTCojXUQUXjKpqp11vWIToIVB84gdts1KS0zghVVgyM76r3vzw8WtvfYqDZ/qStXSgnlyndZJwX5xynyOeYGXSaOKtTVEg/OEPtmEQPAYMg2XnPUYdCGYCC7JNxkirMpoytPFdzVq3IA==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(136003)(376002)(36840700001)(40470700004)(46966006)(47076005)(2616005)(31686004)(956004)(40480700001)(31696002)(86362001)(478600001)(16526019)(26005)(336012)(6706004)(82310400005)(36756003)(316002)(70586007)(70206006)(83380400001)(186003)(40460700003)(5660300002)(8676002)(44832011)(53546011)(36860700001)(82740400003)(16576012)(82960400001)(356005)(110136005)(8936002)(81166007)(41300700001)(2906002)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 13:04:45.0811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 0bd9286f-8536-4942-22e9-08da583d9b82
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT093.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jun 2022 13:04:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8606

On 27.06.22 14:57, Kanagarajan, Vijaikumar wrote:
>=20
>=20
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
>> Behalf Of Jan Kiszka
>> Sent: 27 June 2022 18:22
>> To: Gylstorff Quirin <quirin.gylstorff@siemens.com>; cip-dev@lists.cip-
>> project.org; P T, Sarath <Sarath_PT@mentor.com>
>> Subject: Re: [cip-dev] [isar-cip-core] [PATCH] scripts/start-efishell.sh=
: Add -
>> nographic option
>>
>> On 27.06.22 10:23, Gylstorff Quirin wrote:
>>>
>>>
>>> On 6/27/22 10:14, Jan Kiszka via lists.cip-project.org wrote:
>>>> On 27.06.22 09:12, Sarath P T wrote:
>>>>> From: sarath P T <Sarath_PT@mentor.com>
>>>>>
>>>>> When we launch the start-efishell.sh script for adding the keys into
>>>>> OVMF firmware we faced gtk initialization failed error. So it seems
>>>>> we need to open the OVMF in nographic mode, hence we added the
>>>>> required option to the script.
>>>>>
>>>>
>>>> Which QEMU-Version? Which OVMF version (buster/bullseye/something
>> else)?
>>>> I'm not seeing this, but I'm facing other issues with that firmware
>>>> provided by bullseye (a crash).
>>>> =C2=A0>> Signed-off-by: sarath P T <Sarath_PT@mentor.com>
>>>>> ---
>>>>> =C2=A0 scripts/start-efishell.sh | 2 +-
>>>>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/scripts/start-efishell.sh b/scripts/start-efishell.sh
>>>>> index d451f43..0831f83 100755
>>>>> --- a/scripts/start-efishell.sh
>>>>> +++ b/scripts/start-efishell.sh
>>>>> @@ -2,7 +2,7 @@
>>>>> =C2=A0 ovmf_code=3D${OVMF_CODE:-
>> /usr/share/OVMF/OVMF_CODE.secboot.fd}
>>>
>>> This should be changed to the 4M version.
>>>
>>> @jan
>>> The 4M version does also trigger a crash?
>>>
>>
>> Yes, it does.
>=20
> We have not seen such errors. If you share the setup details (Qemu versio=
n/host distro/OVMF version) we can give it a try.
>=20

Resolved - my OVMF_VARS file was broken, and that was simply causing a
crash. Doesn't leave a good feeling about EDK2 now...

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux

