Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA13C61DA4
	for <webhook@archiver.kernel.org>; Mon,  6 Mar 2023 17:28:08 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.88])
 by mx.groups.io with SMTP id smtpd.web10.856.1678123685403547116
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Mar 2023 09:28:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=N+yLLNDZ;
 spf=pass (domain: siemens.com, ip: 40.107.247.88, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YS6tATj5vYC4rCv8RMFWIG0Sf/QwJgabNRLcO3YWVAq2g+34PsdTgM66vtsAioxBzu2o7BC+FWffxpOEMyjPhMnzTGDJv0niZXwK6bcOQ5rBz20mhka2VJfZTck2PJDb7P15Ecd1/nGaiDF+XnodqmcV8D6igIAg2iiWaiiVhiRMa19e99F/A8nh9erIYf5Jog6/XjHoZNUxSTfOgqMDJYRmIIxPHVI7zUTaw7hW1d9cRrl4JcFpM+wCskfB1uxWCXKPDPbQ2rWhGErHBRWroj70jcsFvAG2sRKH9YdfpiOyH6qLi87xkRQXKBRQjFD0N++Fi8fpu1D0E8Brd8lFsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWOGC4ILEivLw7byyxIqa6nCNIfGtPP9NQwS+ukvAh8=;
 b=ArQo1+lG/Nu+YfZtp5YZE9toHCzzfL/4UTOr7T4PA41T55QV75FkoJdY244ciXhqppbtC4OcgmmF+jRuT3j+kuB7RXZp8jDiLdj6ZvmCk29Le5X12h8/RGCWHVZJ6g1IwHY4DpH7513E7ezJ2KSnEu7QHQlOQSE/UQmo6YArpxMfQKMVMwsiwgC6G1/FMC0r7VTU1QJPLLimEKLsyA3T+UatdrRB8oKPoItAAA1GOJsL4K/A/VBPnNuJF1XnlVoELpipuIJugkOjwGuY9mDFViHeWpwI10LUC5By53fepTHoy03OVxEZ4Vq22pLuAg4eK4qTEDSxr28vv5iNSg6htA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWOGC4ILEivLw7byyxIqa6nCNIfGtPP9NQwS+ukvAh8=;
 b=N+yLLNDZT22ZN46BZVaR4vBjt3OZI5qA+xhZUk9yF4H0d6HXQzFzTHWMM1Pq54MhOUqwdWgGqSwr1sK2rKWJjSRub/2uikmk7I9Ni0evHrs7qej2uP7WaDbaAcUegvzF1ho3ZA4tGKKr6aX7sO4h24YC3rBhFTCTcnc5GeQR38vF2BR8i5ycRCL6M43jcYLdecGPTJUdBu7WWxyhUNHWqPTMPmpFde6KOf79kF67MnaL7xLg9rrtUeNjvO2BgPA6jEbPjga86Y+1F7VrQaOmHVc9GjnQ0ihpmN0+o7wr3lD3655kHdthU63IsAwHys4dBNDZCNJxmfsFAo2Z5P/wgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB6784.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:338::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.12; Mon, 6 Mar
 2023 17:28:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%8]) with mapi id 15.20.6178.013; Mon, 6 Mar 2023
 17:28:01 +0000
Message-ID: <3806f4ee-3a03-dfaf-72b9-fd40180be2a1@siemens.com>
Date: Mon, 6 Mar 2023 18:27:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 2/7] KConfig: add tpm option
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, christian.storm@siemens.com
References: <20230306123926.243471-1-Quirin.Gylstorff@siemens.com>
 <20230306123926.243471-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230306123926.243471-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0180.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf9b3b7-7201-43a9-0917-08db1e6822e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4mNqhJG9Nz5k3wC4gjvFtBeOj8GUMqjVNLb4YeKQavtEe8nt1E92AP4QZY5wbwaR34ZP2ZpU7A57BzhnvQlpG0iTQXSiw5qb6dVlNFENbiZg9sDCBVdBUgZ0YDOr72PltgvESdiaFpRegfCgeeMTrNSm+soU9asakNqs5SGCrUBfk5Qb38gP7v3eL64We4uK51b4hDEqKwnZcxoTgoJACPBoqG7Op4Yg/p3k8Q9NdBtg0L2vxPMfY/nyOFOWlIzBZZeKqBlnzTUjU4NVQP4Hd7yR/RTEappOCDJWcZTn2gYDet6b/okSSsdSy5q+Mjyk2pTATlquAC7y8upX95C5+gnIwK19K4jsz+MA5xblGKG1rpXpNUx+85n/vzHGS55Qwgv7hU5uND6e0kHucldHp5G1zZEgMADUzimW8yB0si12pxlx8wgJVJDIB7mm337KRzfYYy6djtHCJVWyG108sacIGUsIn+006DmOXyaB5KrUKb1kGtQdVV/fevrXTkKmUvEJ8IM0xnlPRRyOwuagJaNMttEfwo7gO1/utvEuQLvXNdI799h8luB+pjpZ6+2cNThCraNPZ6kND2L7ASt/p9UgZf0jWrBtsDMin9EOm8izxTabi0oajTJH9IX43bSJ0iyc+cTEJhscsW/3S0YHHam812khLfnJexHeUNTqX0R+rXSUjBhxqzywuKIMHRzC4jMsXSRpKhzZBdNKhaXeP87KyPqiOn477eoA3+Prf0c=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(451199018)(31686004)(6486002)(6666004)(53546011)(6512007)(6506007)(186003)(83380400001)(2906002)(2616005)(478600001)(8676002)(66476007)(36756003)(66946007)(66556008)(316002)(26005)(8936002)(41300700001)(86362001)(82960400001)(38100700002)(5660300002)(6636002)(31696002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NHUwNWh3dWVTMnZ4WkRJVlZFZGMzM2o1a3hiSTN2RDNhVFR3eUgxYXlRUDBr?=
 =?utf-8?B?UU9rakVMOXlpTi8wYk9WSUtaWk1hZzQ3OGtJV3h6MzNyZlBsekl5OGY0TFdj?=
 =?utf-8?B?ZExsNFpKMzcrbi91dHNad2NLYW9OdWNTRm9WcFJYZUxXbGdnSzQrUnlnZEFP?=
 =?utf-8?B?ZXdQa29zaExwbnkzMHJDbGNyVFF1VThwUlUyMTNYcjZ2RzhZZDBxaGZoRW1v?=
 =?utf-8?B?bStsREtwcE5CWEVORmppMlljY080cHUrMEUza2pSdkZDSnMrVXcwSG5IRXkv?=
 =?utf-8?B?NkxGWktjTFBLcmRhVXpkZHBaZWpxSWhWcHpMUEZlS0JiOUhPMS9YVE1hditj?=
 =?utf-8?B?ejJVRUxvUUZjOWVnZC9yZDRoV0RGZmtTTFRYNnFyenJrVTkxajV1blVzT1Br?=
 =?utf-8?B?R2V1ZGNDWmpJRzk1TEdsSE42Z25TRjEyd25LVXgwZVFLRHJnSUkyNFNUT3J0?=
 =?utf-8?B?R0k4U2UwRTh4WUdtMzc5MHo3UWtUQlBYSUFUTlEvQ0RnTHNjeXdJNFV4NmRF?=
 =?utf-8?B?S1dhdHladnRKOERmelZkZmxZd1daVCtjWVdZcU02cjRQU0IyUHVWNnFXTERO?=
 =?utf-8?B?K3BlZzE0MVRYQXVRK0dWamVwWnYvOThpVi8vTlhkN3REajFTQUNrZytjT2xN?=
 =?utf-8?B?VjZmdkd3TE93ektnQTMrWnJFaVB4dlJVcnB6S2ZubjZCZnBPYk5XVGZxY3dn?=
 =?utf-8?B?WDQ4WmlhdytZRkFOTGNtSGJCNHErdHpzSWczc21iTnpNanBRWGcwUjd3eUht?=
 =?utf-8?B?cWx4SGNwVGRaRkJvQUczcE9rQUdQRjNKWFp4ZVRFVTlpbW9qS1JKOFI2RzlU?=
 =?utf-8?B?clUzUEFGdDZzV3drMEsyMGhqNkYvNDk1eDRGUHFKeUs0WW1ZTlZibWNaNWhv?=
 =?utf-8?B?d0puVVBidkdpcnB0WnBLeDBiOVBCM0ZkU0Y2bWF4MmQxdzN4dndSeHk5dHMy?=
 =?utf-8?B?Uyt6ekI1UEkwZFFVZlBsSmNmekcvdzFFc2ZaYjJ0VFBrZmxUdGVNeDMyNDJm?=
 =?utf-8?B?SUNTRk1JSkhGcTZ5Y3RlaDBEQ1Y2bzc5b25ZaC9HT3Q4QjJiOXI4MVpKbGwr?=
 =?utf-8?B?WW5rVU5hVERPVHlaNjFvMzBYNUhqWUJ1ZWZBK0hnVUZsMUplbUNkZWsrOWFW?=
 =?utf-8?B?bW40WnQ0cHlRYXBYRlhtQjhQaFVtVmxncGF3aEd5YXRpck5zSXU0L1B5MlZF?=
 =?utf-8?B?YUt5ckVKOGExODVyTVM3VWdycjdsMkFlR3B6Vmg4bTg0YWVJTmVDV2dRaWtk?=
 =?utf-8?B?WFhYamtaL1hoM0JMMnE5NE9RZWFzYkFSVVQxRUZSR1hzRFdqZGFKTmVqN2x2?=
 =?utf-8?B?d3A1dENyL1dreVBIbE9TbUlHay9IUi8vTjJNWjI4T0hMN2xPdVJHYmFnb0Vi?=
 =?utf-8?B?OGNBUzNNdVZ6L3FDQjRQdVhrT29tdktsQTE4TEVGYnVtdmU3aEprRTVnQXFR?=
 =?utf-8?B?ME56R2NpOTY1RzgrcFZZT1dkOEYxYjMvQ2JGRWlUWmtPVklYSGxqU01oMGVZ?=
 =?utf-8?B?OGt6VHYwTGVPdCtYYVptb2x3T0thaUJqY0cwNHRSWjg0TTVLYVVFU01mTXQ1?=
 =?utf-8?B?RjZyZDdKQWpycXljUDArNHF2UnhTSzJuWHRXVkJZOW91WWhDdkZ6dWZvbmpl?=
 =?utf-8?B?bGY4TitHVTNRY2lTT2p4a09MdSsrSTVFTm1mcGtVZm5aQ2F1bDlCSUc5QjFq?=
 =?utf-8?B?UXIwVHZ2WDhvbXRFbE9UWGlKMWcwYWlwZzQwcXNyU0xMMW5mTGNhRlIyRGdx?=
 =?utf-8?B?blNraFZ5T0FmM1k2YzFXRFIrQzJmcmRkVzFTMTUwdWNkYTFhQXdnN2tDZ0hR?=
 =?utf-8?B?SXN2SmlYM0RvVGZXMW1YQVhiMGFablpUT2J6M1BmbE5waDg4c0pVbCtaMnpn?=
 =?utf-8?B?eTdRTnF1Ry9aK09xZmx0RXliOEN3QmxsSXdzQ2xvUmxORjRqWW1MT0ppV0FX?=
 =?utf-8?B?UkxSZnAvRlBDRTUzbXpzRVhaN1J3NVN4NVRPcGNlcTIrOTNNV1VJdzNjTXQz?=
 =?utf-8?B?UUduL3Bsc25TMG9GajA2ZVNMU3JELzJyZ1YyRGJ2TEI0Y0ZRR1ZiZ2d4elZa?=
 =?utf-8?B?R2ZXVFBRalI4d0xpWTJWVkw5TnJBaVlPN2k3OURJZ1gva0h3K2JERXFsdXgz?=
 =?utf-8?B?S2VjRXNjMUI3OWl2VEpwaFpsaDEvM1pCcUN3ay9GMUJQQmJLWFBrOGk4alFm?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf9b3b7-7201-43a9-0917-08db1e6822e8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 17:28:01.5527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EshdLuhB0BwRpZx74KlRSJK4D5UXkCwf0UuW0KzuvLuj2c148jNP3afX/dQrlo2S0asmp+7egKtn2nsf5r3FOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6784
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Mar 2023 17:28:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10944

On 06.03.23 13:39, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  Kconfig | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Kconfig b/Kconfig
> index 7d72094..7ce87d0 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -193,4 +193,15 @@ config KAS_INCLUDE_SWUPDATE_SECBOOT
>  	default "kas/opt/ebg-swu.yml" if IMAGE_SWUPDATE && !IMAGE_SECURE_BOOT
>  	default "kas/opt/ebg-secure-boot-snakeoil.yml" if IMAGE_SECURE_BOOT
>  
> +config IMAGE_TPM2_ENCRYPTION
> +	bool "Encrypt partitions on first boot with TPM2 (Demo)"

Why "Demo"?

> +	depends on TARGET_QEMU_AMD64
> +	help
> +	  This enables TPM2 encryption for the partition given in the variable
> +	  CRYPT_PARTITIONS from recipes-initramfs/initramfs-crypt-hook.
> +
> +config KAS_INCLUDE_TPM2_ENCRYPTION
> +	string
> +	default "kas/opt/tpm.yml" if IMAGE_TPM2_ENCRYPTION
> +
>  endif

I'm struggling a bit with the naming and description (throughout the
series). The feature is actually data encryption. The fact that we use
TPM2 for key storage on x86 (and possibly also some form on other archs)
is an implementation aspect.

Let me think about it...

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


