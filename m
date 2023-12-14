Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52CAC4167B
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 08:10:26 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.77])
 by mx.groups.io with SMTP id smtpd.web11.17330.1702541419137559382
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Dec 2023 00:10:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YIoPR2Zh;
 spf=pass (domain: siemens.com, ip: 40.107.6.77, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAX+wdbnePLoCQYTzbUhk8WQaxK+SQMBAMrgV6YV0QxrmxcOeRb3AjGD5S2HXVnvoeV6RuUa4N3gE1crmQD/3aKs6b6jZu90UnOnVl+vNRsP1eywOFM3k8wBIXsUzZ2waCVqoEiivDUMC2zIqIBmI5YKbR/K4FO8fvxpSn8rCrfbYHx4+lm5iRPiUm81fQGPczIQNZjJ9FJ3h24Jckk07A1MJlFlbe2LvvmHM1EOEvpCPioQGA9oRs3TV4hTWykarSfLoR0YK1SKH1+7jrkN/VDh2A3xwMHpoEjCkxjAZoVy9AA6ugZXEn3CGbCUs2GJW0xqpHTgaFnZUynB5/5x5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgCkVjbQj9gBr5Qfxj4eoKbtfiuq+lmpmzESrEz1XXQ=;
 b=bRhecm48OppqnJAzzY5MFoATpmHuPiEuI5HOaYxDrVHHh8alZz1EUo5/cTfR2YrPJRO/r8GnnTBjpp6jZ9sWCgASnrgynjzDlNiA+rIVKOR6flaCkl7vO0M7NIQYcYiUW7e2xzyAEQ0lMTmzq0bhOqN43EOm1ZFtU3knMlsc1TrCcy9Y9P8rSnRZ2xEqKLmfASV7wiXXnOS0ZXikQTyeQmY3/cI/ZOJZ3nRi1GZCbFFUiUuOYkPtlcIeXdkuS5GI5XGXEQJPqIbIqI0eI69blS2p6863tLWqV+kCNo+v5Za9n81ADDfku2VaTEPD8lGp6QCheL4bH8w/HVnN1n+PUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgCkVjbQj9gBr5Qfxj4eoKbtfiuq+lmpmzESrEz1XXQ=;
 b=YIoPR2ZhBtfGb9zUiKxz9Rkv/zoQQFBYjiFmo1la0g2P+zZPz449etR5Or7b0Zoj5KK7uZx/5c3nV028Db/zdiE/N2qM9xExBSGr4TmKONGWnlXsO/8jl6WupwlNaBpBcLEFmrxhzIRAS17qWgJ8X6xRx0uRjuvQhZ8VkZbe9GaBr2Rb166umCcRF4dm5Ajgu01WpvlXnxy+QdEA4grbi6NA7jBNJU+iNOX9e4RWzzxukwFCh0OsfXlrkCa1mSrr+cG5EHR1QBY9Ki/+wI3vgwnK1M7WAvOFvnr8PjpfpQs4lYb0WLy/2A78wV9UWGz/Qjtsd6UziM4T9AaYf25jrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PAVPR10MB7378.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 08:10:15 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a40c:1061:b15e:cbde]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a40c:1061:b15e:cbde%5]) with mapi id 15.20.7068.033; Thu, 14 Dec 2023
 08:10:15 +0000
Message-ID: <65df5d97-ada0-44a1-860e-95e40a8c8a5b@siemens.com>
Date: Thu, 14 Dec 2023 09:10:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] swupdate-certificates: Fix
 shell error
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20231211203432.846459-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231211203432.846459-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::19) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PAVPR10MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e281f43-dede-4664-04e6-08dbfc7c1a4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	D1k/htszF6Qg3oNkm41UzBOA31hfHTWq7YhuWxADwgZrLWA6o4Oq7LatTsdsfxY6UcL5OTdCgjP67PPx6O90P5IcExJ5vr5Y1Q+r4vWQmOEOzjZ7BkKk+DaKd/hU0gOSOdmxmGpbXC9ijEoa1rpisaMrQ23Ru6gQooPzd3WSlfJEuK7BnjjkdpVlFF4FJPt+ewjxEl9fRoY0t09Axl4lwzR6cRd+tV8sq/Jd1jqAN/vY2lF3/FiTf68MNyH3+7HQXzZN/NOSAN4i85am/FAdC8ltKeU9UwK7avpPEu9q0ksH/pGJfsv4nsAXEfEkun+fmwf9UFV9SDK6JpXi38OrhUsJ5bowFm2xADFHB+mMmR+H8pmcZtK5XZ+tlFQW//wGs7EoLP6bLEYWj9zYpmtImJc9h199OlCV8wyVupA4jGXsOGvuQm1usopk8n1jv0lupRINFRu7ZBnqo76D/HrvwE4pR39Dk8P0HR/v8iiq5+h1J35tfuOHjszVN4TLKp/lbT/ShzIPBPxC3DBViRWLNwKOn5iRqXgEyYadS/dRUChXe0tLIFuKRbDqKtO+JDBOgU2v6xo7qGuz+Cd6H7ARq5dFFc8yWPkvW+fvIQnbgEzMimwaNFcrvzvWTnVmqUiMJuqbvvETb77yoahdpxCeTA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(66946007)(66556008)(66476007)(316002)(31686004)(478600001)(6486002)(5660300002)(44832011)(2906002)(8676002)(86362001)(8936002)(31696002)(83380400001)(6506007)(6512007)(53546011)(6666004)(26005)(82960400001)(2616005)(38100700002)(36756003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c3N5Vm1lSVRYNWlZWExOS3lOTGxBWXQ3VVFxb3NHSWFLL2NnMnFSN1BsUUt2?=
 =?utf-8?B?cmwvdFQ0K1piQVJSVldydDVBeWdCQi9PZ1BwQ0d2d3FISEwyUytpaUJuZ0dy?=
 =?utf-8?B?T0Z1b0R1Si8zSWZOaTlidmNsOFYvdlgxODJhN2pyZkJkODFMU1lDN2FzL1dn?=
 =?utf-8?B?S2lGdEJadFQwQmI4OExSa2tSOFZYc3RJWkJVbUU1YVJhZUFROG1OR2hWVVJr?=
 =?utf-8?B?M3BXR2ZlQkRmNElsZjFOVEJ5dVY2a29jUTdjd1pjYkRpbGtqN001cEFSNDFT?=
 =?utf-8?B?dDkyK1VrME1EOVlhU04rMys4cmxHTE9VN09nWm9Cc3hhc1BPLzkrRjltUkZO?=
 =?utf-8?B?cHBVRUo0TitzNFVpT3BkSlFhMzJ0dTZWUllyWDlMMWRBRTJnRk5ORVJPVjc2?=
 =?utf-8?B?ZGE4K0JJTFRFTE5nZXd4eTNDL1pESCtWQ25mRW9LZDFjcVJUc2JQMGNkdGR1?=
 =?utf-8?B?TTR4SzZVbFZCcUM2ZUw4eS9jenB5Ukw5YUJHR25yK0k0TWVVSGtlSnRmWDVj?=
 =?utf-8?B?aVF2YUpXNXBWWjBTakdtejF1NnpSYVdrbW95REk0dTZ6c2prOUdEbTh0eWF1?=
 =?utf-8?B?Umk2bmdlbWpmY0FMVk84NFdCZjNCdE5Sd3cyUmdEaWxhUlF2WEN2NU51STZv?=
 =?utf-8?B?Vko0aVdpeStVQXZCcHBkZmlBaXgvWnl4cWVsajNUT0ZEWWdlV1hzb2pBRVk1?=
 =?utf-8?B?MmJRdUNyYWpkQVI2NVFUOEtJdEtLRm5DRU03OHRZbUZJNTZsYmxQUEl3Zits?=
 =?utf-8?B?bCtJbkxkRDNuczRuZDRRSFJsZWVqNEtGUUFkNzBEMS8xOGxMNG1hbGlRSTFK?=
 =?utf-8?B?cVErU09WL00vU3BKbFZEeDk5eXlUbW4wSmtGdVY4bHRJYjNMa2ZvRmRGQjJ4?=
 =?utf-8?B?OUtIMnpKT0pWVFRZVE1abk1iK3IzV2NZK2pKVE8wdGNMaEROSEIwVE1rN2da?=
 =?utf-8?B?YzdsZFVhRnZPMHprSDE4aldaeGFZN1JaVHdCclVuWW1LKzFtSklUTWdqTWVz?=
 =?utf-8?B?QTVvdUNlOEMxVWpkMjFlaGc4TTZpNmFTQ0dJelRNcVJoM3NGWENDZmp2bHls?=
 =?utf-8?B?ZE5NZHFWRWNlUjJiOVQrR05UQUptR2tnaFFzakc1cXFGWXgrNHFBZFp4ejZS?=
 =?utf-8?B?T21wZ1gvNTdVWnp3UkZBM2MwN0tsVzYxT1R6WHNWb1R1UG9sYytBOUxlVG5w?=
 =?utf-8?B?SUp2MjNTTERxVmNLaXgxWDJ0N1Jaamh4ZTJLQVhSWkJJeFdsTlhnRkl2UXNI?=
 =?utf-8?B?YUdQSUtBakV0c0xiZ3Q0U0ZjU1UxTVFjU2RZWkJ6SGhxbnJzRUJwVG1UYTFk?=
 =?utf-8?B?bGNlOXVQajkvN21PRTlGOHhDUjRBMHhkV1BCZU8rcWZCc0RVWW1TRVBwTVN2?=
 =?utf-8?B?QUwvejZLby9sdjZvR0wrZjVJTHV2c3MvM0UrTDN0cTdMNldTZGxqZnhBeGQ2?=
 =?utf-8?B?MFJyTVBrdFkvTmdGMDRFWFdNa2lPRU5VVTQ5bG56Z0Q0bGNaZSt4ejdHR3Ju?=
 =?utf-8?B?RDdFd0tSYzkzTE13VTl4cHZDaWd5S2s2L3ZnU3ArVGtWcnM4R0l6MzFnemN3?=
 =?utf-8?B?NzFBUUdPWVFzY1BDaWRWNUVxRTYvZkkzaU1IdGIzRWwyK0tBaktVMHJsU1JP?=
 =?utf-8?B?R1hudVFqT2pGenlRZTdOaHlCK0s2d1ZsNDBiS0tqMHZNakNPRWlYTDZzSDlF?=
 =?utf-8?B?ZktWZnlhWlk3Z05jYms0ekJuTnN4U3lRcmQ1Mmx2dWxxUFVXQWZsdGU4bEFZ?=
 =?utf-8?B?UHB2TTZxaDhrbSt2cHR1cm1MOTRRRlNSbmZLZDVMYVRNZksrNmFyM3lNOVdk?=
 =?utf-8?B?ancwZlY3K1VIVTBJR1ROelg0eDQyVDRMME5BRENvWWp3Rm15Nlp2WWNXSmxH?=
 =?utf-8?B?UkFXRnVFN3h6SnpuMVVUdHZDei9oVmdnVUsrOS9ES3FGcGhDV3djQnBSVEk1?=
 =?utf-8?B?cGlodmt0K29MbU1oUGpZYVl6VWVhYzBNT0FuRnBNQkZvRllsbVNxaGFaQU9i?=
 =?utf-8?B?MHc3a3ZxNUltZ2xYenFlRkZWb2ZJclZESnp4aGd0c2x3elZ4NlR6Y2gxV3Zn?=
 =?utf-8?B?Z0tFdVpqcUpMeTZTeWJmWGRicXB0YnRLZG9BbGpseG5ya2tOUUxyR25YUzRp?=
 =?utf-8?Q?wApI4HG/b3iD8MvVCL0/OmxRU?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e281f43-dede-4664-04e6-08dbfc7c1a4e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 08:10:15.2309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJS72CCZd1x5hpA4u+HwosZ9rEZLp385xWrgqBLQhL952Hzd+510aDLgC8+pANN9TMqxTUFJH4D+Uv1pv3DK8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7378
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 08:10:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14087

On 11.12.23 21:34, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> 
> An Additional bracket was added to all if cases, which leads to build
> errors if the variable SWU_SIGN_CERT,SWU_SIGN_SCRIPT and/or SWU_SIGN_KEY
> are not set.
> 
> Introduced with daa9e6738d1763a953fadc4de6010fe8dfddf27a for SWU_SIGN_CERT and SW_SIGN_KEY. 3a4b25d introduces it for SWU_SIGN_SCRIPT.
> 
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../swupdate-certificates/swupdate-certificates-key.inc       | 4 ++--
>  .../swupdate-certificates/swupdate-certificates.inc           | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> index 0b3e045..d3d2e16 100644
> --- a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> @@ -21,11 +21,11 @@ SRC_URI:append = " ${@ "file://"+d.getVar('SWU_SIGN_SCRIPT') if d.getVar('SWU_SI
>  do_install[cleandirs] = "${D}/usr/share/swupdate-signing/ \
>                           ${D}/usr/bin/"
>  do_install() {
> -    if [ ! -f ${WORKDIR}/${SWU_SIGN_SCRIPT} ] ]; then
> +    if [ ! -f ${WORKDIR}/${SWU_SIGN_SCRIPT} ]; then
>          bbfatal "You must add a '${SWU_SIGN_SCRIPT}' to execute the signing process"
>      fi
>      install -m 0700 ${WORKDIR}/${SWU_SIGN_SCRIPT} ${D}/usr/bin/sign-swu
> -    if [ -z ${SWU_SIGN_KEY} ] ]; then
> +    if [ -z ${SWU_SIGN_KEY} ]; then
>          bbfatal "You must set SWU_SIGN_KEY and provide the required file as artifacts to this recipe"
>      fi
>      TARGET=${D}/usr/share/swupdate-signing/
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
> index 0553c25..6673383 100644
> --- a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
> @@ -18,7 +18,7 @@ SWU_SIGN_CERT ??= ""
>  SRC_URI:append = " ${@ "file://"+d.getVar('SWU_SIGN_CERT') if d.getVar('SWU_SIGN_CERT') else '' }"
>  
>  do_install() {
> -    if [ -z ${SWU_SIGN_CERT} ] ]; then
> +    if [ -z ${SWU_SIGN_CERT} ]; then
>          bbfatal "You must set SWU_SIGN_CERT and provide the required file as artifacts to this recipe"
>      fi
>      TARGET=${D}/usr/share/swupdate-signing/

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


