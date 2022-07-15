Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABF9CCA480
	for <webhook@archiver.kernel.org>; Fri, 15 Jul 2022 06:31:03 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.50])
 by mx.groups.io with SMTP id smtpd.web09.3594.1657866660866674528
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Jul 2022 23:31:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=AnvdNgeI;
 spf=pass (domain: siemens.com, ip: 40.107.7.50,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkHPbLn0sEfnNKnxtJY7zHNcD3vVGWNnVisABiD1x7T/9O0j9yCPojF6t3UQC5XSEyOX/wS7RWHnZiak9xJrtm6y++37rF1g86BIAxe4ql6UuyJc2sJ1J8UAeGFYPrVdZs4ocsNnhS2HfkjKumenEzMpYM3nxmP10e0Qs7byGe7TQ9WVErsLt6ZCFpgT6XN3QgVUftq6B+BWTC4KiB8Ia9WmfgaLNbDoZ2jHe33iZ4aSJNcVpYT9CXuxA/zOnfmxuZtzpIITQGBbARxMsn0MEhf0qf6KvdEWL/X7iIzFKmg2vDdMwFj6C3xhL9qYPoPStAw7LWhvV1Arm18WduYSlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVouXUraNsOis+zwNf8yMPvTBltvItn99JGstNhPunk=;
 b=jyJUQ7qPMgioTT5MZdPKjf20vJ+bmvSSldruBuDOxnQZxVfSecQdDz2edQS2JuGu36Buj4KkGQL41mS1FmtFGUsDDufVAphocR1HJDo4hxF6n0qYqq0dD7DRFRyzr0CK49AFGnEw3wmwr6sv5H0bKs+FLdXB6IVOku4NWXV+s8K4G7ufDQkCjRH9WEm6f4yGnEfudQ4oLzh2JiYFL7brzE5Ne5PrGo/4Z8L4uGY7BLmsLoX2cmqXSZzGS1sPTE8uHf9jaHTSOk1sm0Bfir0mtTwTtWCqzZOWv+gP7EFMf4vpgE/5hWGqeLs7smhpftXUhbPOFRxrzlBqQEXRvswzpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVouXUraNsOis+zwNf8yMPvTBltvItn99JGstNhPunk=;
 b=AnvdNgeI6RJxcrYAZ59QJXPk6Hsijt6OnQeMBMm85MLtz9NJZ8rRlwFuUiOjDxNv+nmEFWUynMBkK5uI1pNcFML6H6Xmv9TO2+d+0fTM7Vftpb5Bt57NnG2X638R6PYEMXqhjYeXr+ugSK1aT6lgkReCwah00GEGOYXpuhLjYUpD0xCQQnQvbSxDlbSzvnSt8JTlrHaFABNdzbU9FoROkEo5kEsqy7zTjvtVlyHxnURHIsbb2hIvIFfeBscOnDddNulxZTbxi2HQmx5OyjaOVe9Jb2b8fj4GV6cmmog8DOlqVr0x+nUgVDWQOc7WifoAUr1pMY34KY2J+MRjmxWjXQ==
Received: from DB7PR02CA0011.eurprd02.prod.outlook.com (2603:10a6:10:52::24)
 by AM0PR10MB3041.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:166::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Fri, 15 Jul
 2022 06:30:57 +0000
Received: from DB5EUR01FT101.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:52:cafe::bd) by DB7PR02CA0011.outlook.office365.com
 (2603:10a6:10:52::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15 via Frontend
 Transport; Fri, 15 Jul 2022 06:30:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 DB5EUR01FT101.mail.protection.outlook.com (10.152.5.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 06:30:56 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Fri, 15 Jul 2022 08:30:56 +0200
Received: from [139.21.19.39] (139.21.19.39) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Fri, 15 Jul
 2022 08:30:56 +0200
Message-ID: <f0f53564-0e8d-4d39-fc13-94950af0fea8@siemens.com>
Date: Fri, 15 Jul 2022 08:30:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [isar-cip-core] README.secuirty-testing.md: Add steps to verify
 CIP security image
Content-Language: en-US
To: <Shreyas.Karmahe@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <Venkata.Pyla@toshiba-tsip.com>,
	<kazuhiro3.hayashi@toshiba.co.jp>
References: <20220708075113.3917386-1-Shreyas.Karmahe@toshiba-tsip.com>
 <OSZPR01MB887721281A65202BF4563431DC8B9@OSZPR01MB8877.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <OSZPR01MB887721281A65202BF4563431DC8B9@OSZPR01MB8877.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [139.21.19.39]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--29.642800-8.000000
X-TMASE-MatchedRID: rSftH29dIPRo0FBZlmedToldd8VMUiC5/k5m7D0YTS/x5KZMlKYS/bAG
	3NFI6r+gj4jFvt2M5IJPpjLRqc8GlpGWXUZnUCoxLqM/k1zU9QoFUNcS8I6saKqHmm/V4M/P0Nn
	UUVMlTKZ65yXsx03DxKf767Re+9N4Ewp428RLL8mvY2LZATy8h3B1FmXNIjKm3nHtGkYl/VrId1
	+nCKlIfi62hjZS0WoYRr7gV267sGIDVRiwVZQLlFF8ksjLFtVx9c0SSBk6D85crmR4Jr5uaOMrh
	Et2jBCjEd+K6O5Nt52YZNCJVuN3JZLLGEPsiojDj0IvV7jlqDhovGFNoIkoj/Iq3+8DQd0oeMbJ
	Rkymq5gtg96xGBa1q+dfCLLUCFDrscWOuT6GTfcW74vaPP9DVYflQr2/kJT/30kDaWZBE1TKIqA
	q0jIHivdG7cmuMnEo+WAX4qDxTxFFpnQehwL2Jl46lgXxWrD5hZjBFcIvqt2JUlmL3Uj0mJyqUJ
	2uHKFAvId8fH0notJsjZj0X6YRpfN8y4ht/nM64PRqZKS9s0XVkMfli98jxCoiRKlBVkYIVFeUP
	Ajsd8YrEhPKeemfumMWvMMU24Z7zjKA8eD8J4E1ES3k9kULCljg5fX+Iw/Rbl4CKqupkMr0VPvT
	0zx0mIc9Jc7K8Zqmo8WMkQWv6iWhMIDkR/KfwLkblkrgCLv43QfwsVk0Ubv+efAnnZBiL6nKAIY
	oU8L4F5iXm5LZACA=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--29.642800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 2E28C2A73809DF17D644F42E16801D41F80FFB29E323538F9254C0D5825EADB32000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 424f9523-c695-46cd-0b2a-08da662b937e
X-MS-TrafficTypeDiagnostic: AM0PR10MB3041:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+qHOhdNXhHrN0wEtaJnX3sx+02Ihjo7+aX6x7t96l7IfiiuBl4AJrHZ39ETq?=
 =?us-ascii?Q?l3rHPuO3wHnNRp4YzaI8cXPGTmz/SfebJpNtodAQR5wdggmRv3MP/Vz66RH3?=
 =?us-ascii?Q?dL2N2diA0CaDZxWxZ7+AsjqmsX3YnITxzBnhODqDq3IUn6ji6z4wGmbvSksV?=
 =?us-ascii?Q?PYwt2UzU8+oD6HB/1tU7t4njQOu1NCcG8ynzTncCrmiVESktCaKBScNqLxdL?=
 =?us-ascii?Q?H5cgOvAHqRwD/nYTIbPxkZjYHhLyPPJVi+O40qgU7Fkmclmh5WsC5kB67Pvr?=
 =?us-ascii?Q?rfXQ0NRCaURoTS86zz/4wja+EBkY3Loo41ED7X+1ZmN8/rQnXnb2HEiyirdg?=
 =?us-ascii?Q?0z7mgfUsDVFh1LdPmKZb8K33WUD1ZRluDXsd1GtxTP/luyqk/r+5OWlhf2QH?=
 =?us-ascii?Q?ns7eeE0CAsBCNgKSdUI8+91r+xQoedQNazskA17u5D2v+NkzeafAZ5QXQTns?=
 =?us-ascii?Q?t8WBud4tQFyV4aOFwJkGInjsuWG3JL8SXhqbQOa3TI1PxStuW6qE2HZuQK1B?=
 =?us-ascii?Q?TaErhl+Aa4CRdt81Dux3yddRXODh4S6iE/+DFbIBUhwlY+/TySv70dDZBwda?=
 =?us-ascii?Q?WXNO4MyyZWHHmVvUgypxbyFh2r7f1O3HKDhwTgm8AvNCLfpm7vf0Ji45s2BF?=
 =?us-ascii?Q?ynpCPnPm4/6u0XXTvZ2w2mH8BucLEYn08Yk6QPKlvZ6IAinGZZEuoarbShIA?=
 =?us-ascii?Q?0zmbEmL0AjTx+s7QZZrwFxCDSIgyvQfBbc5GzzHSrpfpdbIVc8rxCgvUD/TW?=
 =?us-ascii?Q?Qn1TsT55aPmDgPDBWPqTUTyB9bln/hl3138ye+8xFOmdk/SvDt9SsSehVJHj?=
 =?us-ascii?Q?5c0/KrRgLK5l0LRQZUjMiMU60fweg5AUFz/2mDWoDKKgABGjBSX4IxSbj1QY?=
 =?us-ascii?Q?SJrhRb5RWiNw/MchsLbG0sYqOqIxR33/Wc+T+clfNm8UzbpPkY8AOwrwOC5N?=
 =?us-ascii?Q?oZ1/Uxgq7l8CG+hbkJsjpAKmvEJjbO9YqhJ4peMD03Fsu9lB/IrJMZ+kx+VD?=
 =?us-ascii?Q?Vjbq?=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(39860400002)(346002)(36840700001)(40470700004)(46966006)(16526019)(47076005)(82740400003)(2616005)(82960400001)(8936002)(36860700001)(336012)(31686004)(2906002)(36756003)(5660300002)(186003)(40480700001)(356005)(44832011)(70586007)(8676002)(478600001)(6706004)(70206006)(26005)(53546011)(15650500001)(956004)(966005)(316002)(81166007)(83380400001)(41300700001)(54906003)(110136005)(16576012)(86362001)(40460700003)(4326008)(82310400005)(31696002)(3940600001)(43740500002)(36900700001)(47845001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 06:30:56.9790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 424f9523-c695-46cd-0b2a-08da662b937e
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT101.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3041
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Jul 2022 06:31:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8785

On 15.07.22 08:04, Shreyas.Karmahe@toshiba-tsip.com wrote:
> Hi Jan-San,
>=20
> I have shared the below MR patch request that covers the documentation st=
eps to verify IEC Layer Test on CIP security image but unable to see this r=
equest in mailing list.
> Kindly let me know status of this MR

At least it made it to my inbox - and got lost there as well. Applied now.

Thanks,
Jan

>=20
> Regards,
> Shreyas
> -----Original Message-----
> From: Shreyas.Karmahe@toshiba-tsip.com <Shreyas.Karmahe@toshiba-tsip.com>=
=20
> Sent: Friday, July 8, 2022 1:21 PM
> To: cip-dev@lists.cip-project.org; jan.kiszka@siemens.com
> Cc: karmahe shreyas(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Portin=
g) <Shreyas.Karmahe@toshiba-tsip.com>; dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=
=BC=A9=EF=BC=B0 TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.com>; pyla ve=
nkata(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) <Venkata.Pyla=
@toshiba-tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =E2=96=A1=
=EF=BC=B3=EF=BC=B7=EF=BC=A3=E2=97=AF=EF=BC=A1=EF=BC=A3=EF=BC=B4) <kazuhiro3=
.hayashi@toshiba.co.jp>
> Subject: [isar-cip-core] README.secuirty-testing.md: Add steps to verify =
CIP security image
>=20
> From: Shreyas Karmahe <Shreyas.Karmahe@toshiba-tsip.com>
>=20
> This document helps to build cip security image and verify the IEC layer =
using cip-security-tests[1].
>=20
> [1] https://gitlab.com/cip-project/cip-testing/cip-security-tests
>=20
> Signed-off-by: Shreyas Karmahe <Shreyas.Karmahe@toshiba-tsip.com>
> ---
>  doc/README.security-testing.md | 80 ++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 doc/README.security-testing.md
>=20
> diff --git a/doc/README.security-testing.md b/doc/README.security-testing=
.md new file mode 100644 index 0000000..b29531c
> --- /dev/null
> +++ b/doc/README.security-testing.md
> @@ -0,0 +1,80 @@
> +# CIP security testing
> +This document explains how to verify basic implementations of [CIP secur=
ity requirements](https://gitlab.com/cip-project/cip-documents/-/blob/maste=
r/security/security_requirements.md) in the isar-cip-core security image us=
ing [cip-security-tests](https://gitlab.com/cip-project/cip-testing/cip-sec=
urity-tests).
> +
> +# Pre-requisite
> +- Necessary debian packages to implement CIP security requirements,=20
> +include them in the recipe=20
> +[cip-core-image-security.bb](recipes-core/images/cip-core-image-securit
> +y.bb)
> +
> +- Pre configurations in the image, should be added in the `postinst`=20
> +script of security-customizations=20
> +[security-customizations/files/postinst](recipes-core/security-customiz
> +ations/files/postinst)
> +
> +- To run `cip-security-tests` the image should need additional package `=
sshpass` and rootfs size should need atleast 5GB, add the below configurati=
on in kas/opt/security.yml file
> +    ```
> +    local_conf_header:
> +        security_testing: |
> +            IMAGE_PREINSTALL_append=3D" sshpass"
> +            ROOTFS_EXTRA=3D"5120"
> +    ```
> +
> +
> +# Build CIP security Linux image
> +Clone isar-cip-core repository
> +```
> +host$ git clone=20
> +https://gitlab.com/cip-project/cip-core/isar-cip-core.git
> +host$ cd isar-cip-core
> +```
> +Build Security Linux image by selecting necessary options ``` host$=20
> +./kas-container menu
> +    Select QEMU AMD64 (x86-64) as Target Board
> +    Select Kernel 5.10.x-cip as Kernel Options
> +    Select bullseye (11) as Debian Release
> +    Select Flashable image as Image formats
> +    Select Security extensions Options
> +Save & Build
> +```
> +# Boot the Linux image
> +```
> +host$ ./start-qemu.sh x86
> +```
> +
> +# Copy security tests in to the Linux image
> +- Clone the cip-security-tests from following URL ``` host$ git clone=20
> +https://gitlab.com/cip-project/cip-testing/cip-security-tests
> +```
> +- Add test user in Linux image to use while scp the=20
> +`cip-security-tests` ``` image$ adduser test ```
> +- Copy `cip-security-tests` to Linux image using scp command ``` host$ =
=20
> +scp -r -P 22222 TCs/ test@127.0.0.1:/home/test/ ```
> +
> +# Run the test in Linux image
> +- Go to following directory and execute IEC Layer test ``` image$ cd=20
> +/home/test/TCs/cip-security-tests/iec-security-tests/singlenode-testcas
> +es/
> +image$ ./run_all.sh
> +```
> +`run_all.sh` generates the test result in file `result_file.txt`, and ou=
tput look like below.
> +```
> +TC_CR1.1-RE1_1+pass+11
> +TC_CR1.11_1+pass+22
> +TC_CR1.11_2+pass+30
> +TC_CR1.1_1+pass+5
> +TC_CR1.1_2+pass+6
> +TC_CR1.3_1+pass+7
> +TC_CR1.3_2+pass+4
> +TC_CR1.3_3+pass+5
> +TC_CR1.4_1+pass+7
> +TC_CR1.5_2+pass+13
> +TC_CR1.5_3+pass+10
> +TC_CR1.7-RE1_1+pass+5
> + :
> + .
> +[Truncated]
> +```
> +Each line of the output will have this \<requirement=20
> +number\>+<requirement pass/fail>+\<time took to execute this test=20
> +case\>
> +- pass - The security image is meeting this requirement.
> +- fail - The security image is failed to met this requirement.
> +- skip - The test case not supported by IEC layer.
> --
> 2.30.2
>=20
>=20
--=20
Siemens AG, Technology
Competence Center Embedded Linux

