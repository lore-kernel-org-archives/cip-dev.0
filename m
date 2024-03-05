Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987D9C54798
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 09:19:03 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.89])
 by mx.groups.io with SMTP id smtpd.web10.17816.1709630332972730744
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Mar 2024 01:18:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=uhPUypx8;
 spf=pass (domain: siemens.com, ip: 40.107.21.89, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWB9mTw+TthVIEdL7lk3Czm877vKEe/QRJkev8kYeR1l141IYDVsYiWXwMfF4wP8IFTa+dxDdSydsXXgZkbrcfFJpwMhFixNt0fSJnWZCnLZ5LB9NUQzs2NX9Xfv/IdYDQ8ozdVHZsppxYyJ2H3tPuWxgUoHo9F7pnhpYVXNXCWOTHvALL7yROT/QC/HwGUOEJ+8S/dOYz+sO7rgErEf/Wb2VEJ6HdAxPsmlHDd9cixoi7eV4tEx++APlc095vCsVjw5zQYFefv09Xr4Jqn1wbdbfyGlSd0rY6n0T8ytol767PDjyoBgWPMFIM4nbfWviDJbv0cBLS/lRLPSrmp8Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9Z1/Ivo3wsJa2S61/omyDpUKpvwF0HL9Hi5BcB6bBc=;
 b=O/Vm1iARDWCRMlaFkMaHwhCUKqn10VcT6Ehv3L5z6BD6mRQEFQgpkOXeMtMeRv5c6nWZO+tSpD17m4MBAmgaKtJOE7vdn/hJGBuElrwBxOW3RwvUX1ovwXu05vOX2wsTzRv4mabwu+pAxZb21OS8qjrWO1MzLMAE9C1aLuYymApOqubHYd87RCNoYFyimXE0Js7eVTiX7lIt37DJwg9OTLsZHURHhpo9AUUTmL7OK2k6GSrE52DSiLOkePICpHXr9AfusgsK0Hrz9knp0D6xBl0+RPxET/CUhyxliKArFQLYcUo/M9Vrl3XXFIJmE3PKVLt2Jg1Vqja5ACpl1GQJ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9Z1/Ivo3wsJa2S61/omyDpUKpvwF0HL9Hi5BcB6bBc=;
 b=uhPUypx8LerNOPyy2giOa5O9KVWrU+yiSqY3YbcMy6frZjYAT4OCE/JGCW1Ta6wlP5xIb/p7aCn1/UeXftdNZckQ8tP63UrgQvLLzEBJl+lcB0ZzNzU+FGn0BvuJRix8OkIVG/k8sHMBaYF9Z/WcE1H9PP9rgn3svviYCpkOpXkgAawWZ5A7kpRsn1f8qFLgtvwe1LSwKTWy799WLa8/pIQEc2qq4KYb8UjNClCK+CzmSjRfYehPumrxje8MsCHPDhqCg7qktf46oQgYW/AKWEbbK48+FnBDtwLs0jpyiwzlWGYcSy2H+PffAjDXQONJh1FuQkbU/C9B7rj7i/4+XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:116::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34; Tue, 5 Mar
 2024 09:18:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 09:18:48 +0000
Message-ID: <4e3220ce-429c-4f5d-9066-457443412bf2@siemens.com>
Date: Tue, 5 Mar 2024 10:18:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate_2021.11: Backport raw
 handler unmount fix
Content-Language: en-US
To: Tobias Schaffner <tobias.schaffner@siemens.com>,
 cip-dev@lists.cip-project.org,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20240301121241.259677-1-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240301121241.259677-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:610:b0::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8178:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dfa2154-6b6c-4bea-6ea6-08dc3cf54409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4jyAcL6QhOQnRplipjXt96Y3kpJ18d1vJgFOtOzr3LYeTIUY3NB/M+dosXxmlEKgpNAIe1DluKCQsMpfNsw/tc5E9ssjaAJeY6MP5ZHiAEV4bBaejePZx5DiWiUzIw7Wuv60y5k9pxGyASv1moYfzC4cHCY2FwF25wqT/DLieBpF4qvP4GRbj0KxOhOfphgElSW/zFbgBQMHcsPperAf+wWIcGlE/RLokqdv+HTTHVRA3mOdPVRGeJeVZ9+nXJ5M3kFun4s6LMnUQpDiHP4vf2QvmIMiHxz7PLADkin5vVyKmC/8roS85kQ/aSiDJ0nmwAcYI1h+AYdJLzMQKdGOYRtDUQKEcOiPDOqd3gw0U0wD/K9dFRMmZI9VDne2AjFbH6ehLuCSK7Q7QcLHAFiup0ZIQZfw5Ec8vzmyUDTmC/GQPAdbxBMePRf9Q6tSXO6sdgUM2Lu3bYoMz18Gtm+iw+hWFA3SGZrRcu7s0SB/iPF6RcrJhjsyquoAFdqLWZNuZ9Vx51l7fHcrTqsB1QOUKmvHieiEvl5Zgc6oyfr90l6n2A74Dd8mUktJsdPndeXvGe+MzdWlE2EGsNgel8N+lqPQFCcLMGuntegxbs4nAAVPN01XaN80Zfd+nW89VsDXEtfc3BbI1W/8uwYB1Tpv3ZT02dgS6e5DGQKh/ZAHsPA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RHBOM25OOGlpSmhTNlk3bFA2Nkp2MlJtcTZucktPMXk0dGp5V2lpR2FmZERy?=
 =?utf-8?B?SWNpWFdpTk1Tb1J0QmtDWjRvWlhnWGdpMHNDWEpyaWgrMlhtdzhURHh5VTdi?=
 =?utf-8?B?aXVOR2hYUmdLalp6OFFGZlZJb21Uc0RDUXdIV3ptRGljUnpuL2ZRUHlyWWV4?=
 =?utf-8?B?dktRWFIvcTFBSW8wOUM3UUl5MkorTXJHOThhaFhoSFBJRDk1QXErN1BVVmg5?=
 =?utf-8?B?SnNTWlJXNlpQamJ6NDlKaCtTdTNqZzJydGZnazdsbm9jQnNqelRwK3ZtcHM2?=
 =?utf-8?B?UGE0a1NXNmg2M2k0REJGZmpBdjdZazIweW9WUCtORjFoRGVDc2dzZzJtWC9m?=
 =?utf-8?B?Y3dYczgvS1gycUVhc2FxUWVxSmlnZ1JiZ0U2R1hZZFhWQ09DTkVZTElRMThk?=
 =?utf-8?B?SWtZbTVNY3NkRGdHa1ZQRFpWQVR6VkJyeHJGOHE2RFI0UUJCSmN4MXc4d2Nu?=
 =?utf-8?B?K2F0RVNBMHJQUURqVHEvNHlwOWRGVGFRcGdZZWZFeEFQRGY1VFZxVVRjVTZ5?=
 =?utf-8?B?aENqbXcwWitqRTVkRWp4N09nVlJST21qZnRqOC9zMHpmb09Zay9VMmk2OTJS?=
 =?utf-8?B?eHRWb0FyeGRQQk5yWWVHSlBOK2tpU3lKNTF4RVg0M2w2NExjTTRnRWpYRkhU?=
 =?utf-8?B?UW4rY09RWGtmMUlYSU9pNUVlM1pMR0d2NnVXTnR4NzMwMm5SejFoWktOS21Z?=
 =?utf-8?B?bEtzbzRnQnNLNmZ3a2hWMGJLc2gwc2tzeUFBZGV5UlFvaXk1RFU0SUVzWXVT?=
 =?utf-8?B?NW9ucHNZaWJZeE1nVzdJNC9NZHNLTkk2eTJST29DZWI1dW5JM0U4YlkrN2Zj?=
 =?utf-8?B?TmcwdFQvR3JYMWtGdm03VU9KT2JjQnpySUZ0V1BIcUNGN3gzcE1lM09rbzlF?=
 =?utf-8?B?MklmMHl1TG9lOU1WRzc0d1g4WTg5aDlqNjc1M1lJOGNmR2ZkSjdDVkZPSkw0?=
 =?utf-8?B?TDgvTDFIWHdReFluWGpRWVBLQjc2dkdyVjArTnRKRmFxWlhhbGtOeDlHZFpz?=
 =?utf-8?B?YloxR2lQZlIzcDZaYzhMZEVGM1BFaUh2S0tKSVV2VDluL045bVBKV1E3cXZt?=
 =?utf-8?B?c3lBdXVqR2dTc2hQaFZvazE2WHNQSjl4ejBJeXZWUTBheWdLUENjT3dOQUFB?=
 =?utf-8?B?RkM1R0pUQ1JRN1k1bkpGcXdUN3hmaCt4RXEvOHVHT1dDK2I4Q1BIa1M2c2NW?=
 =?utf-8?B?dm1YU2hKU2ppM3A3TXRRSk1Nb1BhYXFHaUswWCt1MG14YVhkTFhFSW0rYmxs?=
 =?utf-8?B?NHc2Skh5eXFCYWxjS0hvY2ZISkdMVFFxOVZmSVBGeGt4NmczQUFsc3J1M0FJ?=
 =?utf-8?B?MFV5dWUzVXZGRE1mYmtXVHVQdjVWK2NrbzNqZFN6VVZ1S3llZHRuaXoyTk9k?=
 =?utf-8?B?Y0pWbUNqVlB1RVJYTVFQV01hNnBpVHY2dFNjaEVSWG9WaEFodGd3enJqWWV2?=
 =?utf-8?B?YjlhQmpwVEJFV1VZb3plUkVUb0dVRitxSDNtVW12R2NJRjZpNDJIUHg4MWgw?=
 =?utf-8?B?bnlOcmlDdUlmRjRmd2FHY2ZkU3RLQ2ZsZWRyVCt6VkEyems5UHdGTmZxUFdQ?=
 =?utf-8?B?TGVVNEVtL015enQzWUF0WXRMVG8xQVZKYWN6WFZXUkMwNzFLKzg5Q1JRRnpJ?=
 =?utf-8?B?cnVwM0U3K2EyWWRQeEErM3NLM3N2Zk1wZ2pzUWVUZ1NFdVMzd1VZMHc3djZn?=
 =?utf-8?B?cksxRkNVMnltL1hXbHZPZWUwV0hqc3N5Rm8wTTFDN3dTbHFjR0wwa0tGK1dl?=
 =?utf-8?B?cldoWXBxU0toNXdrL0Nzc3lHWFJDNk9IVE5KQ2dMSFlsa09BeWZ6aG9aaUdV?=
 =?utf-8?B?YjFsa0RlL3NBWHRJUHBHMmRuaVF2emN2RVdIV1NPSjFiajdDTzRaUDZlSW5X?=
 =?utf-8?B?YWh1clNEeUljeUhiYld3cXM2cGh4NFBlaHNIMG1sUm1VTVM5WU9QczFHRVI0?=
 =?utf-8?B?SGRuN0k0UEw1MlNZTDFtWjVzcjB3TkQzS2FOTkVNV09pbnNnUlNQWWYwN1BQ?=
 =?utf-8?B?eHYvcUFEQkdPNnJ5TmhsYXZaZjIrckV6ZFIxQU5nUU5IZ05UQ1Q3clRsUno1?=
 =?utf-8?B?WXIvUnp6ajM0cWxEbGN2RWV1c0F0V2o5b1VkcVNiaGhVdDUvRWg1aGNzVTA2?=
 =?utf-8?B?SmhJR3h1SFdRYytSRmxLOHE0OFlGdmxpbW9rcWlTbFVZWlRvT0p4aTh6K1Ry?=
 =?utf-8?B?Wnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dfa2154-6b6c-4bea-6ea6-08dc3cf54409
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 09:18:48.9254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69XoZW2Pf2keX7OhMHiWJLg712kPPoa/3sJyVSr6/qWcm3egx4c4tpi/rOy57wt+yz3ujCaJ1F70AHn8ZFwJOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8178
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Mar 2024 09:19:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15213

On 01.03.24 13:12, Tobias Schaffner wrote:
> Swupdate 2021.11 has a bug that clears the boot partition if installing
> a kernel file fails. On error the boot partition will stay mounted to a
> directory in /tmp which will be recursively cleared.
> This is critical if A/B partitioning with efibootguard is used as the ebg
> environment will be destroyed making it impossible to do further updates.
> 
> Backport efc06332bb0bd622e6b542e0d3bd15135629d06a to fix this issue.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  ...ian-backport-raw-handler-unmount-fix.patch | 165 ++++++++++++++++++
>  .../swupdate/swupdate_2021.11-1+debian-gbp.bb |   3 +-
>  2 files changed, 167 insertions(+), 1 deletion(-)
>  create mode 100644 recipes-core/swupdate/files/2021.11/0006-debian-backport-raw-handler-unmount-fix.patch
> 
> diff --git a/recipes-core/swupdate/files/2021.11/0006-debian-backport-raw-handler-unmount-fix.patch b/recipes-core/swupdate/files/2021.11/0006-debian-backport-raw-handler-unmount-fix.patch
> new file mode 100644
> index 0000000..fdea66c
> --- /dev/null
> +++ b/recipes-core/swupdate/files/2021.11/0006-debian-backport-raw-handler-unmount-fix.patch
> @@ -0,0 +1,165 @@
> +From faae516d5c06dc13b953002fd91c0ba3e9bba7d8 Mon Sep 17 00:00:00 2001
> +From: Tobias Schaffner <tobias.schaffner@siemens.com>
> +Date: Thu, 15 Feb 2024 10:43:12 +0100
> +Subject: [PATCH] Backport raw handler unmount fix
> +
> +Swupdate 2021.11 has a bug that clears the boot partition if installing
> +a kernel file fails. On error the boot partition will stay mounted to a
> +directory in /tmp which will be recursively cleared.
> +This is critical if A/B partitioning with efibootguard is used as the ebg
> +environment will be destroyed making it impossible to do further updates.
> +
> +Backport efc06332bb0bd622e6b542e0d3bd15135629d06a to fix this issue.
> +
> +Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> +---
> + ...nmount-target-device-when-installing.patch | 128 ++++++++++++++++++
> + debian/patches/series                         |   1 +
> + 2 files changed, 129 insertions(+)
> + create mode 100644 debian/patches/0002-raw-handler-Unmount-target-device-when-installing.patch
> +
> +diff --git a/debian/patches/0002-raw-handler-Unmount-target-device-when-installing.patch b/debian/patches/0002-raw-handler-Unmount-target-device-when-installing.patch
> +new file mode 100644
> +index 00000000..f291a8bd
> +--- /dev/null
> ++++ b/debian/patches/0002-raw-handler-Unmount-target-device-when-installing.patch
> +@@ -0,0 +1,128 @@
> ++From d843a97aa56817c2c48dfb4f4b50315cdf753328 Mon Sep 17 00:00:00 2001
> ++From: Sava Jakovljev <savaj@meyersound.com>
> ++Date: Wed, 31 May 2023 23:44:22 +0200
> ++Subject: [PATCH] raw handler: Unmount target device when installing a file
> ++ fails
> ++
> ++Make sure to call 'swupdate_umount' in every scenario in
> ++'install_raw_file' function - this patch thus solves
> ++problems when an update fails on installing a file, and next update
> ++cannot be done because 'swupdate_mount' function fails with message
> ++"already mounted" because the  mount is still there from the previous
> ++attempt.
> ++
> ++Signed-off-by: Sava Jakovljev <savaj@meyersound.com>
> ++Signed-off-by: Stefano Babic <sbabic@denx.de>
> ++---
> ++ handlers/raw_handler.c | 65 +++++++++++++++++++++++++++++++-----------
> ++ 1 file changed, 49 insertions(+), 16 deletions(-)
> ++
> ++diff --git a/handlers/raw_handler.c b/handlers/raw_handler.c
> ++index 619a2f47..ac6a2030 100644
> ++--- a/handlers/raw_handler.c
> +++++ b/handlers/raw_handler.c
> ++@@ -206,8 +206,9 @@ static int install_raw_file(struct img_type *img,
> ++ 	void __attribute__ ((__unused__)) *data)
> ++ {
> ++ 	char path[255];
> ++-	int fdout;
> ++-	int ret = 0;
> +++	char tmp_path[255];
> +++	int fdout = -1;
> +++	int ret = -1;
> ++ 	int use_mount = (strlen(img->device) && strlen(img->filesystem)) ? 1 : 0;
> ++ 	char* DATADST_DIR = alloca(strlen(get_tmpdir())+strlen(DATADST_DIR_SUFFIX)+1);
> ++ 	sprintf(DATADST_DIR, "%s%s", get_tmpdir(), DATADST_DIR_SUFFIX);
> ++@@ -228,7 +229,7 @@ static int install_raw_file(struct img_type *img,
> ++ 		if (snprintf(path, sizeof(path), "%s%s",
> ++ 					 DATADST_DIR, img->path) >= (int)sizeof(path)) {
> ++ 			ERROR("Path too long: %s%s", DATADST_DIR, img->path);
> ++-			return -1;
> +++			goto cleanup;
> ++ 		}
> ++ 	} else {
> ++ 		if (snprintf(path, sizeof(path), "%s", img->path) >= (int)sizeof(path)) {
> ++@@ -237,35 +238,67 @@ static int install_raw_file(struct img_type *img,
> ++ 		}
> ++ 	}
> ++ 
> ++-	TRACE("Installing file %s on %s",
> ++-		img->fname, path);
> +++	if (strtobool(dict_get_value(&img->properties, "atomic-install"))) {
> +++		if (snprintf(tmp_path, sizeof(tmp_path), "%s.tmp", path) >= (int)sizeof(tmp_path)) {
> +++			ERROR("Temp path too long: %s.tmp", img->path);
> +++			ret = -1;
> +++			goto cleanup;
> +++		}
> +++	}
> +++	else {
> +++		snprintf(tmp_path, sizeof(tmp_path), "%s", path);
> +++	}
> +++	TRACE("Installing file %s on %s", img->fname, tmp_path);
> ++ 
> ++ 	if (strtobool(dict_get_value(&img->properties, "create-destination"))) {
> ++ 		TRACE("Creating path %s", path);
> ++-		fdout = mkpath(dirname(strdupa(path)), 0755);
> ++-		if (fdout < 0) {
> +++		ret = mkpath(dirname(strdupa(path)), 0755);
> +++		if (ret < 0) {
> ++ 			ERROR("I cannot create path %s: %s", path, strerror(errno));
> ++-			return -1;
> +++			goto cleanup;
> ++ 		}
> ++ 	}
> ++ 
> ++-	fdout = openfileoutput(path);
> ++-	if (fdout < 0)
> ++-		return fdout;
> +++	fdout = openfileoutput(tmp_path);
> +++	if (fdout < 0) {
> +++		ret = -1;
> +++		goto cleanup;
> +++	}
> ++ 	if (!img_check_free_space(img, fdout)) {
> ++-		return -ENOSPC;
> +++		ret = -ENOSPC;
> +++		goto cleanup;
> ++ 	}
> ++ 
> ++ 	ret = copyimage(&fdout, img, NULL);
> ++-	if (ret< 0) {
> +++	if (ret < 0) {
> ++ 		ERROR("Error copying extracted file");
> +++		goto cleanup;
> ++ 	}
> ++-	close(fdout);
> ++ 
> ++-	if (use_mount) {
> ++-		swupdate_umount(DATADST_DIR);
> +++	if (fsync(fdout)) {
> +++		ERROR("Error writing %s to disk: %s", tmp_path, strerror(errno));
> +++		ret = -1;
> +++		goto cleanup;
> +++	}
> +++
> +++	if (strtobool(dict_get_value(&img->properties, "atomic-install"))) {
> +++		TRACE("Renaming file %s to %s", tmp_path, path);
> +++		if (rename(tmp_path, path)) {
> +++			ERROR("Error renaming %s to %s: %s", tmp_path, path, strerror(errno));
> +++			ret = -1;
> +++			goto cleanup;
> +++		}
> ++ 	}
> ++ 
> +++	ret = 0;
> +++
> +++cleanup:
> +++	if (fdout > 0)
> +++		close(fdout);
> +++
> +++	if (use_mount)
> +++		swupdate_umount(DATADST_DIR);
> +++
> ++ 	return ret;
> ++ }
> ++ 
> ++-- 
> ++2.34.1
> ++
> +diff --git a/debian/patches/series b/debian/patches/series
> +index 98628a77..21a82863 100644
> +--- a/debian/patches/series
> ++++ b/debian/patches/series
> +@@ -1,2 +1,3 @@
> + use-gcc-compiler.diff
> + 0001-bootloader-EBG-fix-do_env_get-for-anything-but-globa.patch
> ++0002-raw-handler-Unmount-target-device-when-installing.patch
> +-- 
> +2.34.1
> +
> diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> index 2384f41..5671cfa 100644
> --- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> +++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> @@ -25,7 +25,8 @@ SRC_URI += "file://0001-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
>              file://0002-debian-rules-Add-Embedded-Lua-handler-option.patch \
>              file://0003-debian-rules-Add-option-to-disable-fs-creation.patch \
>              file://0004-debian-rules-Add-option-to-disable-webserver.patch \
> -            file://0005-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch"
> +            file://0005-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch \
> +            file://0006-debian-backport-raw-handler-unmount-fix.patch"
>  
>  # If the luahandler shall be embedded into the swupdate binary
>  # include the following lines.

Looks good to me. Quirin, any remarks?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


