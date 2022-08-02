Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E784C00140
	for <webhook@archiver.kernel.org>; Tue,  2 Aug 2022 09:15:51 +0000 (UTC)
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (EUR03-AM5-obe.outbound.protection.outlook.com [40.107.3.49])
 by mx.groups.io with SMTP id smtpd.web12.3988.1659431741491060183
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Aug 2022 02:15:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=eUdOpEQV;
 spf=pass (domain: siemens.com, ip: 40.107.3.49,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFGkIAal1tYEyNmGnm9UhTnaDvM2Y8pEHSfoTdtCJAQ+zbR/coOou7Uh/zSG7vGSKyMZDwllgxli1KK2S2pTTQmiTh9u46/1CXl6gKm8jyYeefqOxSFSk7d3cU3KzDqaLCEKwAyo7RIpCTjxs+4/PTQ3dxC9ITI9Om0z4Wn4EczGb+eJFzl07h5GwtntyYPbLwce/aTtp16wTe6Qf5L9/x1dwA1pd3XcZzStbgmp9UxX1RLGn19Uk8v3iE0yVBBaWXrkg52ovbrghWoZTosVdPKR2ChYnxhO+cwkugwY5Bg4VHBB+3IAcKdJWtf7MfW1Qrswf8cDyocvQeFcPpI3/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXGvj9WVXHKYVYjU9aaSA2MgnCo0nDaxALjEMz0rHLM=;
 b=PRKkf7MVyFBn1VRjANqkphNRHN8YGhyehFFqFgm9uLE1bTtLESUDbDPPJtqKLUyifKdTSkg9BJFOscJqINaR9CwUfK4fPYihygmekGLMdtecQQV4bIEWAhgqsae/9LJPUtWx8f9C9byKoAm0P55IefQW0dyEM0eczre1w8dkHQLyciQCmPZNV50bEcxSqtc5N4QCr6m5kyNj2Q1FogUWYDJ2tPWkhLAsOBMsAwRtd/04y5DDCQXkJNO87BSX5eXRUJUBORfysTTw7yTgpyJYzL6+ZyjqDYPxyudklMuP1F+dtu/pl/zFEmT7HcevNtNEaEDJqNhDddoyII+YsiGnlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 194.138.21.74) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=temperror action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXGvj9WVXHKYVYjU9aaSA2MgnCo0nDaxALjEMz0rHLM=;
 b=eUdOpEQV4of9l0KShCT3ixt1fEf7dbZzNqCLhXX/wTJHiTQ+zEACYsDezVg2SP0e15rkzGER7VwAerDcabzLe2UAQ27/FMv7nFG1bJDRneECGyDVi3Vl3g8Awb1akjgV+H2OhxSuT5vvn7fB/YsM8rp/XkYHbsOhipCri7wtN/WaKhqmG+qj/aywjUpwiNLnzRwmP50P5j9vqd/exH4vunYG39NzzmR5JtnHYKhcZ0RYUQL3dld7I39dcY2Bq50YPQX54dgu1FEqVinqmiddCOKtKACscFEKHvSyadp4myBVV0wEDdnlxjg14WVe5cRuLH4DV50FAOACkPlwgaTXeg==
Received: from OS6P279CA0011.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:30::14)
 by DB8PR10MB3388.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Tue, 2 Aug
 2022 09:15:38 +0000
Received: from HE1EUR01FT102.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:30:cafe::7e) by OS6P279CA0011.outlook.office365.com
 (2603:10a6:e10:30::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10 via Frontend
 Transport; Tue, 2 Aug 2022 09:15:38 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 194.138.21.74) smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=siemens.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of siemens.com: DNS Timeout)
Received: from hybrid.siemens.com (194.138.21.74) by
 HE1EUR01FT102.mail.protection.outlook.com (10.152.1.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.10 via Frontend Transport; Tue, 2 Aug 2022 09:15:37 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Tue, 2 Aug 2022 11:15:36 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Tue, 2 Aug 2022
 11:15:36 +0200
Message-ID: <a5ff72c3-25c2-43a3-ef55-ea30714d8db4@siemens.com>
Date: Tue, 2 Aug 2022 11:15:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [cip-dev][isar-cip-core][RFC 0/2] clean up kas/opt
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20220801145749.42714-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220801145749.42714-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--10.409800-8.000000
X-TMASE-MatchedRID: 0ayLSLUekQU5QaOxwNGfvo9bHfxDWoibNtywwIf5ksXW4Mz461fsHEKJ
	5iyNYGPpR/IzlV+CMbaVKkReE4K0FOtq38W/Yl/coJpneC8uzLwGbfRE5Gg+M7+a7Hw+x9qZy73
	3NwuklsK3CLdtdG1oCGBt9mS7pKVTeoqVs1ZLrvAzd+tJEfcx1FxxDx5qbkR9OX/V8P8ail1yZ8
	zcONpAsdmzcdRxL+xwKrauXd3MZDWKM/X3itkL+5NPbSKntaksBOp8xx0bMZau6RXjJEAMcUPCX
	uTQ5kRP
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.409800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 383EBD99913FF0A61792480A3BAB8CD6A911D4FCBDB9DE52469549B49082F10A2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11377540-4028-485e-9b1c-08da74678fe9
X-MS-TrafficTypeDiagnostic: DB8PR10MB3388:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6rr13Pfu3a+lxYOSfhxTZeZ5NZ7HM8fqcwULqzCQMj6Q4LJKG52uq0T0kCdWH9Nck3B48SAUdyg3NArUi5a6R1PQXjMDCwnPgV6k0e9pM8cE+y7N84eahmiaX9BWQ3o1zSxxhW6TvD8q7Sr+4F8i/Tb9uiMDEDODjm45LjNGnrp8SIXGrfk5mvU+RE00YP7T6ZpWpZXxl3ggqUmM0t7a4FAwiiY/HNFpYUv0VWXYYjgooq9/CIV2XlHhreP67vIqY+T2krXc55dHEDD3FMqWsl0VCxmB9LuEL6sPNq3vKtLZE69UDGcQp1l9jH2b/2jgu9F6B+U7LoffQ4HufWrieZIl8umPdOOb24yCODSj6iGiikCVWDJNQsZUGXkgMWKdPrKseJE/UJXmYR96rwU2wtiiu8PDv7k+acIoPlc1dMIqSxlyGQIH91KmY0gf6uQASCnO2kcrirCi8PP3ikiNUA9v8b+B5topm1UQbxiCm+s94cLICqKo7+sRQVXEgy00i21+cfP6vbHixcglLdREG6uWKXJ+fcpOq3IEU2Wsf1NrNfloLQxUImHNZRkWpsLJtRpHtBIZM90mr4VR9YuMWx9XqFYxrMJGIDBACNI6tyMhoSyVkNzI8bgxh1L6SfM/ygfrYkS+Z3bnzrjk6sQaPk02lXLsCKJm9MphOsdIinzFgoEMib/+UPKzYf978/2n1jI5s0hiknhsn5fwcsau5N2iMVNXsqIAYVma7tK9kULSfbnaty7qdZ9OZRGJsr70SN9BNn3oL5YvkCzaWbUMlDujrhdZuRsrirwxTP46inZuHLSRRmSlBBB8CcmH7ZFiPAymk5QsNdRXLqaD+BcOUjk9KFVpaWzFuCy+ughToj9GrWpOO17HE53gUk7AARxQt1CWdCFvPkX3Tg4pcxIa6w==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(346002)(136003)(36840700001)(40470700004)(46966006)(956004)(83380400001)(36756003)(8676002)(63350400001)(63370400001)(8936002)(31696002)(5660300002)(70586007)(70206006)(81166007)(86362001)(40460700003)(2906002)(2616005)(16526019)(186003)(336012)(36860700001)(316002)(16576012)(40480700001)(31686004)(6706004)(110136005)(47076005)(53546011)(82310400005)(82740400003)(44832011)(356005)(478600001)(41300700001)(26005)(82960400001)(4744005)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 09:15:37.0412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 11377540-4028-485e-9b1c-08da74678fe9
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT102.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3388
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Aug 2022 09:15:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8996

On 01.08.22 16:57, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Remove the kas option for efibootguard as it cannot build a image.
> Move the package installation for swupdate to the include.
> 
> Quirin Gylstorff (2):
>   kas: Remove efibootguard.yml
>   kas/opt/swupdate: Move the package installation to swupdate.inc
> 
>  kas/opt/ebg-secure-boot-snakeoil.yml | 10 +++----
>  kas/opt/ebg-swu.yml                  |  9 +++----
>  kas/opt/efibootguard.yml             | 39 ----------------------------
>  kas/opt/swupdate.yml                 |  4 ---
>  recipes-core/images/efibootguard.inc | 26 +++++++++++++++++++
>  recipes-core/images/swupdate.inc     |  3 +++
>  6 files changed, 36 insertions(+), 55 deletions(-)
>  delete mode 100644 kas/opt/efibootguard.yml
>  create mode 100644 recipes-core/images/efibootguard.inc
> 

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

