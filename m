Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61354C43334
	for <webhook@archiver.kernel.org>; Fri,  8 Jul 2022 11:41:55 +0000 (UTC)
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (EUR03-AM5-obe.outbound.protection.outlook.com [40.107.3.69])
 by mx.groups.io with SMTP id smtpd.web10.6554.1657280507775963166
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Jul 2022 04:41:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=cpWd0wJE;
 spf=pass (domain: siemens.com, ip: 40.107.3.69,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkiRlGSdmmd5/WXk/bZj8Wk+PTthDIt90P4aya1PFay+4cKsQRm6gJWcen0UsLc3Ob6P31dPcD1zCsql4l9KEYwpsNLkQazH0TMUotnRWvrhyq4/HcAKK69/Jeix0tFVa/FE8o8A36WdLuKaPWbjpSP8zbGuxytM3wjTCtrwxfIsLUjRgF2AR5OUyCaBdyzwEZWGajmLYJHF/GencOKtEQVn/zgHSaTeFiXHQpa5Mm3+djrkj9asAu1iHMC3fF00d85257GJVlYTEWEij2/M1lszJzSzg+jeB21+6iqHudTDSNuE3aoMh2wQQ4Z3VXMoD9ONYUEQ69spjr+FtDA29g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPS164+6nW4BasETlFz+OoBn63ImwHh2DZC47/xaVcA=;
 b=c46zmIUZx5K/zHmuUFSb+O8tSHiWXqdUZVlOMq/ZC+WeuVk0yOQB5q/eHdTCqpAg+O40B4wg0g21FhWSEpPZO4nUKjM+AvunTm730oqgVLbhomMnyJrZcsLFb1vPp5Hd7ZCBptf1Sk8KmBVKw89YqnYrOUak/RBtXx7iVAIdCoqFgFP/EvysP0vbooM371NxCm/mHGCl/jo+yYBgIiJQ6WZ0/xpgu8fv0783zD+8pE17pSKPh55h8/+6rHyPYWigR9TUJXpiZ4KR/Hl/a5RodRKSxICirxTb443/IXfAg/yi8naDQZqGYiDKkoyXLlHkANFSTNm4tfdfgnKO/u4v7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPS164+6nW4BasETlFz+OoBn63ImwHh2DZC47/xaVcA=;
 b=cpWd0wJE0lkewGMyESQnicba21hpDrb9UDwfyf1vzsiOWnd56yTktBYrdY3XoDcLtmwHdEILlf22njhZSv9YneGgyn+yzxdaXaEg+Cxw75ayNWEHJivaXGIPKSWdVk+BqoLTF2KbP7WxriE65w2Mf2do2JWWnYVm7Xpf0O9FfRKm8xIX3MCRpV/3uju2r6qIsaG+aiIjgmSh/828ydgJJ3BdRMzkEpMB1GXbuzXsbAkdCJN3AhJaOlZae98vx66adEV52lJXdJRonp5oRy0Wni1YUj/i4o8lmkHHvU/zFkopa+a+8tYxcaVc8yndpf/EHVodspmA+4jcnz7A3IBkzQ==
Received: from OL1P279CA0047.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:14::16)
 by PR3PR10MB4016.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17; Fri, 8 Jul
 2022 11:41:44 +0000
Received: from HE1EUR01FT048.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:14:cafe::21) by OL1P279CA0047.outlook.office365.com
 (2603:10a6:e10:14::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Fri, 8 Jul 2022 11:41:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 HE1EUR01FT048.mail.protection.outlook.com (10.152.1.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 11:41:42 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Fri, 8 Jul 2022 13:41:41 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Fri, 8 Jul 2022
 13:41:40 +0200
Message-ID: <2aab94e5-b6a3-d199-b519-f49c9aceb8f7@siemens.com>
Date: Fri, 8 Jul 2022 13:41:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [isar-cip-core] security-customizations/postinst:Add
 configuration for MFA
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <Shreyas.Karmahe@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <venkata.pyla@toshiba-tsip.com>,
	<kazuhiro3.hayashi@toshiba.co.jp>
References: <20220707103331.3912839-1-Shreyas.Karmahe@toshiba-tsip.com>
 <c5593a24-4bc2-b6a4-9f1f-d52e172b68d5@siemens.com>
In-Reply-To: <c5593a24-4bc2-b6a4-9f1f-d52e172b68d5@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--15.705600-8.000000
X-TMASE-MatchedRID: kxpaLTp5p645QaOxwNGfvo9bHfxDWoibi+LMxCH3gaIhXJsS++inji45
	ojdE7FAWAQe1ufITXxx4oPBwjFVS7nxs7qFZ9FbOj0IvV7jlqDhoDvOMa6ennlsX6O8mWQ6mBXn
	gI6jFvpf5q5JB+ib2QU7MpBiz7lGOg7cFeMsvTcVvedD3CYSjHZXi9leWDF7pMKPrF7dK57PKIq
	Aq0jIHigW+MaoIxPn7yHI9pvh+9W/tPH1H++DgEVolspZkNI2Sle+q6k7Q/cwvzLls7HTfGQ5GM
	zfaGfZv/Vp/MlKwCgajxYyRBa/qJQPTK4qtAgwIAYt5KiTiutkLbigRnpKlKSPzRlrdFGDwN8T0
	cph7SsDuY8OJ0aoQNELbNXFfEMTyyRRyASrzUcBAKXfSCl3mbw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.705600-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 9279ED564948781137DE9D2510B08D9D7ECDA81D7044494088B1EE2AD1241AA92000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b338c6e-7504-470d-db12-08da60d6d46a
X-MS-TrafficTypeDiagnostic: PR3PR10MB4016:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8/hegkB12u7QFFM0R2awii6v/SneNXm2MfXDmr7Q2AsH8fH9FGRq3gdvUyF/jb9MGJMnBB9A+EGCU3DsYvXx2+Ay4VtkqeSvtdML8/Twdu6tGPGED8pKvBDDtAMjl76XNiXg4M63k9Pp4uccQGB+P5YAS9u9Z3syNwXkeX+a3k/lwF+0PCZgmg/aZfWMG6bto1DxF7k6fdKIbeHLqcNzba0LyG5niTkS2LJdbkkBocxI3W+k7dUC55TkEwl+LmDJWAXzUh13GG481JVgGkPVq8dokc9mjjXnCZVmx5lphSoikowmhO3nkWDjgdmKVEe4ZOf1xfNzlYcCIsaohIVHuibWUgrgejMkmxenc+/WsaxbsWLw5VDmpcQ0Qrmm6KCJB31iZhas2/3Ucd1bi/IMrXBKev9H+mqbySN3eWrqEZuzbIBXXGI9FC3uCUfIK/VV3nISRU3xXBho12aZftQd1h/1Axa72Ze5cyPMXwfkLTUhClhvzj7fiLOi660VbKzvGY7QqjGRmngZYH8cki2q7K6GUq7GTQ3DbOVRaN0QeGj0JXsl0Cn0Tm4Rjua8t/rIVsJPi266lmMXj0Sdl1GsaB4JN0YZVgpbVTH6qzqSgBAnL92SFA8H/qMFO1gVhzKShL79gum1MhXNBWXqW8AzQD7Lae178PIw95jhssy4KmtX7otn5PeC1R71cojg4FI6KyXRLfcQwGHbJ3wKrrwiwCe6MQePzWgREX9SbfwHA6wn1/woGpEVOx5IrZ9lcOGvMXOV4iaSeh0F68kD29I5d4aOWLQMLT2R+FLlxql+Ai5yhHGM7meTYnYrDD439jiPxIre1umJCtKVHYp5RNQ/nbryV+l6jybCshPbKcEHafbIrGRbhRyDJfdB3v2zM6uaoGnt6MfqrJmJbA0nVM8WvH6QHzAtvhZT/+FuTeSXX9Q=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(376002)(346002)(40470700004)(36840700001)(46966006)(26005)(31696002)(54906003)(86362001)(2616005)(316002)(356005)(40460700003)(82740400003)(956004)(82960400001)(5660300002)(16576012)(8936002)(81166007)(110136005)(6706004)(83380400001)(2906002)(15650500001)(70586007)(44832011)(8676002)(40480700001)(70206006)(4326008)(186003)(16526019)(478600001)(47076005)(336012)(36756003)(82310400005)(36860700001)(41300700001)(53546011)(31686004)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 11:41:42.8293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 1b338c6e-7504-470d-db12-08da60d6d46a
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT048.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4016
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Jul 2022 11:41:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8720

On 07.07.22 12:55, Jan Kiszka wrote:
> On 07.07.22 12:33, Shreyas.Karmahe@toshiba-tsip.com wrote:
>> From: Shreyas Karmahe <Shreyas.Karmahe@toshiba-tsip.com>
>>
>> It configures libpam-google-authenticator for achieving the IEC requirement
>> for Multi-Factor Authentication.
>>
>> Signed-off-by: Shreyas Karmahe <Shreyas.Karmahe@toshiba-tsip.com>
>> ---
>>  recipes-core/security-customizations/files/postinst | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/recipes-core/security-customizations/files/postinst b/recipes-core/security-customizations/files/postinst
>> index 3699ba2..9ba8540 100644
>> --- a/recipes-core/security-customizations/files/postinst
>> +++ b/recipes-core/security-customizations/files/postinst
>> @@ -49,3 +49,14 @@ sed -i 's/admin_space_left_action = .*/admin_space_left_action = SYSLOG/' $AUDIT
>>  
>>  # CR2.10: Response to audit processing failures
>>  sed -i 's/disk_error_action = .*/disk_error_action = SYSLOG/' $AUDIT_CONF_FILE
>> +
>> +# CR2.11: Enable Mutli Factor Authentication for Local and Remote Session
>> +SSHD_AUTH_CONFIG="/etc/pam.d/common-auth"
>> +google_authenticator="auth required pam_google_authenticator.so nullok"
>> +if grep -c "pam_google_authenticator.so" "${SSHD_AUTH_CONFIG}";then
>> +        sed -i '/pam_google_authenticator.so/ s/^#*/#/'  "${SSHD_AUTH_CONFIG}"
>> +fi
>> +echo "auth required pam_google_authenticator.so nullok" | tee -a "${SSHD_AUTH_CONFIG}"
>> +# Enable PAM configuration for Remote Session
>> +sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' "${SSHD_CONFIG}"
>> +echo "AuthenticationMethods keyboard-interactive" | tee -a "${SSHD_CONFIG}"
> 
> Applied, thanks!
> 

As discussed in the other thread: This one is missing a DEBIAN_DEPENDS
for libpam-google-authenticator. I'm dropping this again (was only in
next) so that you can send a v3.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

