Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E880BC433FE
	for <webhook@archiver.kernel.org>; Tue, 18 Oct 2022 07:39:08 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.70])
 by mx.groups.io with SMTP id smtpd.web10.4181.1666078736430257526
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Oct 2022 00:38:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JdnEHFGa;
 spf=pass (domain: siemens.com, ip: 40.107.8.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOt1SSa2p8uZesOrhk669llH5ZBALenOrkELqO2C+eUKrUrM2oBDWeGds1Nl1fin14DZ8g8QFTIvl26uDuWJZ+lnX4sPJ1i2Zo/cQC+Y0cG+RCB4K3cZ/cy5ADhD2cIjr0S6awN1RKAbJVO/GfYpEAW9WERuaGdUGDC7l13Yw23QVHjC8ZY6+mNj7ju7xJXL1ugGIBXVLFwc3KAscOE+WjmMNZYvExEsUx3UERmnIYZO2GIaYHpPClYkXyRno7FQgFetWvbYnAjc3PgPDswlAyrmfydIEeyRQkCFTEfGqtepJOObBUdT+b+P7jvKFzRkD7l7zb2luUH5hoGh6Aritg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sqsra/ixuVu97to4Dds5aXcvtEQFs+y0bXuF3Fe48YE=;
 b=T6zSBo8MTvPybi957pKVgv+IWN9D0eKyDPzJJ3Gi8yRMHa9jvpjAfsLXWtHLkp1ICv4eA/twq3LmGFGnIZ//aXSsfp0bDdFG4vjOTeABKCc4Fn9QPgBkS9RIJRGwMlQG72qxN3z7rN/f7Y3pwhcdzJVhPjFQRpHpFg0PICz/qtB2uQlb1fakcbDeGu6b9p6Ykeb2nmQbqMeFfoOm/TM1fa3eC/iKPKvhOK7z26MkKMmTJEaG76ZS6wjYQVWjiVtA2T69drT2dVdj11Xc0Qd65AqFkWGHp/MblLlgyY312PXOgdJP9K2MQMbKj+KYUwVFUIAHVpNvBPBI3sCJoHl0Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=ilbers.de smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sqsra/ixuVu97to4Dds5aXcvtEQFs+y0bXuF3Fe48YE=;
 b=JdnEHFGai18NG/3gSA/6WPEpZ7fafljlG6q1QxuN3jFqj/iPRVW2Zg8VVY917FmXSqP2oqcfXLaTjGR/fhBWICdVHP93wu0vClwb1FIwxKthV31wUjp8GCzKJtBZ3YAkYrpUmQ2waxxlK5QB1jNxCtB+RcaRibYhEcR7a0R8E3XJDXDPDjmrJn3vLfGOcgk6MeldMtE4H+pqud/qS7mcoMICpo9QAgbQQM1m/MCV0gdzLM99m9ftxYeab4yN7EqHa3b/6QDJRq78sRPfvd7AdX38UrlfMrz0c7eU5oPUQEZxOiwrKaK5vqH+TCw56ZwcP0TW+7f0r2NJwiWZ224VmA==
Received: from AS9PR06CA0754.eurprd06.prod.outlook.com (2603:10a6:20b:484::8)
 by AS4PR10MB5393.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 18 Oct
 2022 07:38:53 +0000
Received: from VE1EUR01FT018.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:484:cafe::fd) by AS9PR06CA0754.outlook.office365.com
 (2603:10a6:20b:484::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30 via Frontend
 Transport; Tue, 18 Oct 2022 07:38:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT018.mail.protection.outlook.com (10.152.2.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 07:38:53 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Tue, 18 Oct 2022 09:38:53 +0200
Received: from [167.87.52.112] (167.87.52.112) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Tue, 18 Oct 2022 09:38:52 +0200
Message-ID: <fbfa7fdc-d127-f5fd-9e66-8e7106be98b5@siemens.com>
Date: Tue, 18 Oct 2022 09:38:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [cip-dev][isar-cip-core][PATCH] tmp_fs: Correct option generation
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>, <ubely@ilbers.de>,
	<cip-dev@lists.cip-project.org>
References: <124d9128-63b4-d0ef-5cf9-7931a017e0c6@siemens.com>
 <20221018072652.10944-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221018072652.10944-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.52.112]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--17.588800-8.000000
X-TMASE-MatchedRID: FSxjOqe5tUM5QaOxwNGfvo9bHfxDWoibx1/NuoFDMxTlCjTeYR3AAfio
	Isi7Sa0gwOYCrUSRilpTHuQZZKa8u63aC25avUuaplCaRSPAyU1Xy1X24O0bxpxVZzZr7+O7kYC
	3rjkUXRIpXgaagqPrSLFWlyiiKoibK+fbv4M7+TC1M6vEQZCbhnDWCEZXvYIHngIgpj8eDcC063
	Wh9WVqgtQdB5NUNSsi1GcRAJRT6POOhzOa6g8KrZAjhTg9NLjaVHcjtt+YzhoESXM3IWF5PVu/S
	cTcEzzw6k+1qyKDiFw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.588800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 6BE99DB78C91C3CA89BE81FFD1124C1F0DE4F9ACA644ABFD40F8ED63B8B816722000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT018:EE_|AS4PR10MB5393:EE_
X-MS-Office365-Filtering-Correlation-Id: 24dd92d4-0012-4e86-66d2-08dab0dbce77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5cDKAIRPhofcQcceQy0hYNRsE0tLxFH6bhxA6IkFYGf8xoqVoVSaedNB5+Xlz05tw60F15cOIttVeuUFaHc1NpVKOBG08flZ9DqzbgHH47UI9tYPXrHbA5I/dnAXEEupZLvtQ5X+6/oQqy6ndDKFJSarH2W02Y4iAoQVg8xk9+pyQR3y4MdVjjYjWzoxGWHSlIF/L+l0kHjUlOZ/5ioFgpuHHreJJflKomquCLUqcqd6qVlc4KvuEN6/98hr6AxBrb4KSqrnswUxccf/fcYIJIHJsXap1IEGGbSsE+GUhudsP6eJzuGXZe4G/GotIzp99PoMIEfYOdGtSWCOPuuofsZ7hVNdA858vyNvyMSgLvTnfuIPG12bk7F8UP1+nC2ZpXYHfKjHZHhVZyg1/hj/WR0LZ2SeAMn5Y1LsYIbX8anuruJXvFfAyHY36bGlr7ATd41Fnjwc1n0PtYrkU+DcCscb2y+EhY7u2N+a3VJAt6LuCCOlMIOawzS7VSDYgOPXKyg9tBs14duLw3snh/ACJCQhkpmfhplUr5MBYFl4s5YIdy7ZlSZ7yVpPh3S8LYmFJrYMZxFsWhJizcaFwj/JwAxyPRwf6l+MJfdPth3npE16NGR3cdvdwrPvZ9Eba/RIe3fOVCSRvdRkoeM3xHNaSmP5YJjlyccbVmeA7KCeus8VX9PE8tHAxdLt5EhdkNc1IxoUONN0ZOQysGf7eMRFNxZfdX/UgZ33S+2kBgoI3b4riyP+vif0HTtBGv5JN8dIYpkVLaFxmGyrWYlRDuSaUBld04U5Dj/P86pbfKvUeD2Sih7wwILkaAWrWbOW/VQ8PWaWTQE8uNapV1ssqQlQuXj7houSIhG1tLf+6Wjw02jED8ZEY+0NuQUqZmpyO5SMH7SUXp+my73zU0TxBYj2uiNSeHuEGs13ytyETWr1cmI=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(40470700004)(36840700001)(46966006)(2616005)(36756003)(956004)(8676002)(86362001)(34020700004)(70586007)(40480700001)(41300700001)(82960400001)(82740400003)(40460700003)(31696002)(966005)(70206006)(81166007)(316002)(16576012)(47076005)(356005)(8936002)(5660300002)(44832011)(110136005)(83380400001)(82310400005)(16526019)(478600001)(2906002)(336012)(186003)(26005)(53546011)(36860700001)(6706004)(31686004)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 07:38:53.4135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24dd92d4-0012-4e86-66d2-08dab0dbce77
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT018.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5393
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Oct 2022 07:39:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9770

On 18.10.22 09:26, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This fixes issues https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/44.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-core/tmp-fs/tmp-fs_0.1.bb | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-core/tmp-fs/tmp-fs_0.1.bb b/recipes-core/tmp-fs/tmp-fs_0.1.bb
> index 3ec20c7..b86b0fb 100644
> --- a/recipes-core/tmp-fs/tmp-fs_0.1.bb
> +++ b/recipes-core/tmp-fs/tmp-fs_0.1.bb
> @@ -15,7 +15,7 @@ SRC_URI = "file://postinst \
>  
>  TMP_FS_SIZE ?= "500M"
>  TMP_FS_MODE ?= "755"
> -TMP_FS_OPTIONS = "nodev,nosuid,size=${TMP_SIZE},mode=${TMP_MODE}"
> +TMP_FS_OPTIONS = "nodev,nosuid,size=${TMP_FS_SIZE},mode=${TMP_FS_MODE}"
>  
>  TEMPLATE_FILES = "tmp.mount.tmpl"
>  TEMPLATE_VARS += "TMP_FS_OPTIONS"

Thanks, applied. And then I applied Uladzimir's patch on top again.
Result now in next.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


