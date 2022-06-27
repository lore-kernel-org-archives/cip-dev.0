Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C439C43334
	for <webhook@archiver.kernel.org>; Mon, 27 Jun 2022 12:52:28 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.48])
 by mx.groups.io with SMTP id smtpd.web10.41221.1656334341775825612
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jun 2022 05:52:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=dXwFClBY;
 spf=pass (domain: siemens.com, ip: 40.107.21.48,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOnBEG9w6H2iLRAnxkuCN4B4vGohu6cdmacVhTgyGrqmKU5+MycNyGMtj+9+Pt7wkcPL+u+y341SFxq8d/d0G2rt2+jw0WJ2UcThTkzEnqtjIgHIi7ZSHMKJOFoEaipHNvMs4c3bwRzlSX7quV7bFYiI/QYSrtkkwYxD9UxRtqDG7KoQXVTfXhUb5nUSoEj3cc7wcC/nGr6stbzLGwaFK99jaHN2dCBcOTYijSGuDr9jNkfkqWzpJ0E6z6FUdU37y+roDGn1+xtr37wZ5T+yxiMBNe6uHJai+WKPh2w14LFrOMEmPm8ugIGQDnKDzTBRvoolgX4BduMcWmqw4EZhQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wap126JwlO4kNJ1gcuOquU8L831mjdUE8E0+namdC7Q=;
 b=f9zAfbJo2gF8OkEUWBWd7gCfOtjQQmHIjOVs5sVmRp7wxWOo9wQ95eg/tQ4slTWLPckoJ5NiAuZR3DROoHaPtRcbeQyR7qvjk4/gHBsDwgNjPEyqHNEOMyyf9JQJFkRWmPzFs3ZJMU3uRzot2LgV/ZvezCLCvTuQdh/Hm0GJhEGXAvg+UDD1Je8SGp/FI/1wlUAuyAcWn8QNqK+wnHI3ONiSlQsUkLF87m2UJBtgDeNl3zM37AK3Rf/iXTJBaefYYOBCFtUzGfvOSboXR1fyVGJ331atnxPKVyu5sUNiCB1uSjUPcwH8GPU1LWbKAak353y/KBeBmtEL4CDKwH7jvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wap126JwlO4kNJ1gcuOquU8L831mjdUE8E0+namdC7Q=;
 b=dXwFClBYcIBxbMR1qNEyFqyccIb3IIpN+t25V7mmfW/iR8QEqPN200nhpf6gaAkr5Ni4YmjF9TzlzwhU+6DWnDrIcjR7Nen59hd6Q0SM7+jy6n3ccvfs0LEhbdzuf76KiEvX8K+Cgb8poDKol7OevHmYGTy9An1lx7p//YjbbLJBppMQXuikG4bCns0w3c0aKDQCSaOO8J0itOoEBQbl7x1XmnJhIzHiGk7xtDRWHF9Gle8h1oiXgKQSZzeuzGuNcEO0/q2cdnQjG93zAfNA1E7iKaktKtWpgAxsJm1pNsopzRuSL3DTPcioyt80YIeKUwCv+i2XmdZv4AkQYrcORA==
Received: from OL1P279CA0066.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:15::17)
 by AM0PR10MB2499.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:d5::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Mon, 27 Jun
 2022 12:52:18 +0000
Received: from HE1EUR01FT045.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:15:cafe::19) by OL1P279CA0066.outlook.office365.com
 (2603:10a6:e10:15::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17 via Frontend
 Transport; Mon, 27 Jun 2022 12:52:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 HE1EUR01FT045.mail.protection.outlook.com (10.152.0.239) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.18 via Frontend Transport; Mon, 27 Jun 2022 12:52:17 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 27 Jun 2022 14:52:13 +0200
Received: from [139.22.133.104] (139.22.133.104) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 27 Jun 2022 14:52:12 +0200
Message-ID: <fef66432-ac36-9e2d-7813-5e123d919bbf@siemens.com>
Date: Mon, 27 Jun 2022 14:52:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [cip-dev] [isar-cip-core] [PATCH] scripts/start-efishell.sh: Add
 -nographic option
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>, Sarath P T <Sarath_PT@mentor.com>
References: <20220627071206.21277-1-Sarath_PT@mentor.com>
 <665fa99b-7ab0-1b8c-3662-c1f1ad7a8d4c@siemens.com>
 <95a32358-94ab-d9c3-c0ac-df0258e2bacb@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <95a32358-94ab-d9c3-c0ac-df0258e2bacb@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [139.22.133.104]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.552700-8.000000
X-TMASE-MatchedRID: 72nS2hokiaTrOhfRe676RwJfVW3wuXXEPg9yfk4YC0Z/x01PzgWkxthQ
	O8CvZj/Xi6TAZSPuSP/BmVUDuFaGsYop/9yuQ2dGZwMCi4ClRgCPizQk3pS52dbgzPjrV+wcC//
	1TMV5chNQKAQSutQYXOmlKJ1QxjeaQ0OVUnaVOxzjKUo3S5uDgSxppiUy9o4cA9lly13c/gEpY+
	dgnkDLaujnKWtZ9LTLYG32ZLukpVN6ipWzVkuu8DN360kR9zHUXHEPHmpuRH2DGx/OQ1GV8t8dW
	DYdvqmp1GcRAJRT6PP3FLeZXNZS4JFOlJCK/1fttEEZawRd3mVv0wmu6BqQHs7RW8xYGiTMuvO6
	K34RxSzFHXWEenPVPfJRYuLc/Ty8
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.552700-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 F070E830EE657EA3B018E08891E384DB6B111A95F3131FB59FF42546CB5153892000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f6ff3ca-1b15-4beb-1095-08da583bde32
X-MS-TrafficTypeDiagnostic: AM0PR10MB2499:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	F//C37NCZWMC2XnODDQfSOmChMGhnGA5H+M5jxr0nlKRxb2oZzCT2J9hCqFmx9ToQ6N8sFbTeo4N1a5bCdGPgqJ9iXwvgRqjfRDLJCMqB8jHaB8RXkIsnmC2gXxfq1dCC0gJVy7bpAOwSvL1dvBAT7MXoKO3SE6YbbW3VOHDHYvTZETVYI4tWw+SAjoBlC13dGVP3FX+9+Y/wtJHEle1/2GJ01jcSEwy12KGXjZVusRkvONH6TTlkoqx3lw58B8PAzgJEp+uXi9jbhrBrOteNqBDv/jvDlqDekqsbN3CoXD5s6uDaN1qz/zr2o4p9+Yq3gzxXFkG4lkqq9PSfR8cDcP4MzzX9V0DtR3ILALiF/gcSEjttyl0/5jWmOrgmNPr16hU+j+BN5hydXI2XH72/rQhBV4ZODoLkSO/b1TKOI0/AFJ0IfY5I8DnrU9y0KJWwoBs2dPe+dp5B7HlESV4OlSpquLTojywPg8M50xE39QtemDQA43wPpj1iykx4QtvznTb4+VNoYmj2g8EndhEzYk94Xiga4tOMiuVkbNy/kYVoP62T+i8nLwTlH/+h0y2wLL/KzIOsc2CF0pLCcNH1tuGdSaefP3dUnghePKcsZiS7NaLTQ1LmSwoEXmU1J0KJHkJYXh+J7wxLHFLeyAnaRxlgyGLCNwhtAkgOlDTyeFgo7CDJ8GEVBfGSrHaP+MtSm2guaskEN5qwvm0HYMvI0v99aMbqolyc/f/1sXlyHWDuUD8c1RSGjfQzcXtQpYM2ye03Hn2KNibxMqs+5MVt8naa1wBocpnEUC59RzUX/5+fjtmT+RHBbsG8iy8AnWtQ+etTmLeGUxMS1XtyQS1RX897cqPqN2hrtB01Ob6VqvbKvjCCCGMg8pmX6xT66D9HpyHWOo/nONllHYi+bvKuA==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(346002)(136003)(46966006)(40470700004)(36840700001)(47076005)(16526019)(336012)(70586007)(956004)(8676002)(2906002)(41300700001)(70206006)(82310400005)(186003)(31696002)(86362001)(40460700003)(5660300002)(8936002)(478600001)(53546011)(26005)(2616005)(44832011)(81166007)(110136005)(40480700001)(31686004)(82740400003)(82960400001)(6706004)(83380400001)(36860700001)(36756003)(316002)(16576012)(356005)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 12:52:17.7671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 3f6ff3ca-1b15-4beb-1095-08da583bde32
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT045.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2499
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jun 2022 12:52:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8602

On 27.06.22 10:23, Gylstorff Quirin wrote:
>=20
>=20
> On 6/27/22 10:14, Jan Kiszka via lists.cip-project.org wrote:
>> On 27.06.22 09:12, Sarath P T wrote:
>>> From: sarath P T <Sarath_PT@mentor.com>
>>>
>>> When we launch the start-efishell.sh script for
>>> adding the keys into OVMF firmware we faced
>>> gtk initialization failed error. So it seems
>>> we need to open the OVMF in nographic mode, hence
>>> we added the required option to the script.
>>>
>>
>> Which QEMU-Version? Which OVMF version (buster/bullseye/something else)?
>> I'm not seeing this, but I'm facing other issues with that firmware
>> provided by bullseye (a crash).
>> =C2=A0>> Signed-off-by: sarath P T <Sarath_PT@mentor.com>
>>> ---
>>> =C2=A0 scripts/start-efishell.sh | 2 +-
>>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/scripts/start-efishell.sh b/scripts/start-efishell.sh
>>> index d451f43..0831f83 100755
>>> --- a/scripts/start-efishell.sh
>>> +++ b/scripts/start-efishell.sh
>>> @@ -2,7 +2,7 @@
>>> =C2=A0 ovmf_code=3D${OVMF_CODE:-/usr/share/OVMF/OVMF_CODE.secboot.fd}
>=20
> This should be changed to the 4M version.
>=20
> @jan
> The 4M version does also trigger a crash?
>=20

Yes, it does.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux

