Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7523C4167B
	for <webhook@archiver.kernel.org>; Fri,  1 Dec 2023 05:57:54 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.56])
 by mx.groups.io with SMTP id smtpd.web11.16688.1701410270030588487
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Nov 2023 21:57:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ox06r7DV;
 spf=pass (domain: siemens.com, ip: 40.107.21.56, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GR4wp5Ipkb6kac8tYdHZpJtJxRDz69JMoQ2/7OtmuZMpjsC1G4iniDNxP/0pXQoxUEF+R8q4/+pUqQYsjb0mJFqTPbcAFq7O/F3zO/wR9VU7ZWlLGaaOiRKyPubykO1ePHIE1+AjRh1DmTigLv0YPwKr0URCHMRFhjqdcAjf2QsWAuWBLwBnSmC39wwCbqJu5QZP97cV+bvZRUHTZYapKCKXwJegE3kzGJs/O7c3wH4oO5kjH+s5qBJnorcqvn8SIE8Tf7DJqkDrOYlc8fhTcz6Xaiurk6bcgC+1oLGmF/zPaotmYGNI+bd0FOxv9COJ8pdHn5fneJOFbBj7bhCVnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vb6RLHpdn9nXaleieJBVzaAkoSeu6gttx5QX4IGlN2U=;
 b=P2ae0HaoMkA69U9TKDdesiqGNXqgBH0jbRFxpap8d8hpg0pwNdV0d+FrgqTaxhcm4WN58c2splp6sBcWIZ3b02d2O4FLwT5H9RTC5wBWoqF/+ER29lvtab9adESax7vUHzygsszzXCA4udTe7rp0J8hEkbFjSeViOx4/clKu+JUtkNsM3awcUCh344uB1CsUxYMCW4/HEZkQBhOO6HYu9QG/L1lt6x1nAESPHmVn8kSlgQX4O2jDgQiV1qqO6yc8zmjG1xYJd00MFOF0bRhhxEUENeNL79+JrenGoWkaXcCOlnL1GuRFdUleDB6qoToFFEYOF18nbidFveJKUOBGFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vb6RLHpdn9nXaleieJBVzaAkoSeu6gttx5QX4IGlN2U=;
 b=ox06r7DVpt7SHS1jL362FGoeutDYqx/U93+ogE68xViarA9GMcakTGmcFMC0CwC2UI66BN87MtabGCjsyJYm6z75RJWl6KSY/ulqnfJI1mWbEyHDOuZqVcHNm2uLlh5QL3wtc/B3xLi4pauUuw0sicZeBYF9g7ssXbTJ3wJRwMykuh/+RIKFDHO8arywmSFlMBIBKqMTALNGcclgsBFGmfMGY6efcnSDTCGADMKwaQSl6KjG1xJ7cPbW5NIRRPncxIGGzQ0qxYkV4vy1jJnxlqozBAvC0UicgTITd3tvQ75hpnpFV2OsdjVvDG+huKGui2MlQuFiBqlgnOYEo7MhCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5751.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:31a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Fri, 1 Dec
 2023 05:57:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 05:57:46 +0000
Message-ID: <a00576ea-498c-455e-b024-4e35ebf31b5d@siemens.com>
Date: Fri, 1 Dec 2023 13:57:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC] swupdate: Move signing to seperate
 script
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, wei.hao@siemens.com,
 cip-dev@lists.cip-project.org
References: <20231124141326.2661397-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231124141326.2661397-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: cba7f89c-ecb4-455b-9a8b-08dbf232713c
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	je5bO//tiheiHv5E1IsFoxRfQdM3qeGhvKGrKsVeHtTIWP4gigQ/rPf0fWQOKjL7zmbwhmi++YHgDGD2SgpX9w32caG89Oj6DOYtb8FTAAKrfF/H1s5kOXnwEuBac1oEwDFj91LxEzp3OKN6WH9BzB9YU3pqM9bkp0f9YF+xtieTE7We98+838IdGXYs2TfuUEINV8EcaCJlrtK+1gqJZsggJxFKGB8Yt6Ub3cu+i7NA0zadhUT465XJ5zA+Iefq0kvD1WQAuqT6wJFYs4mUyq49CIk1IICWqty/yjqV4nYJ+K4cSbTDu1cJPPMgLw32NZPRqlcRK3aho1MsSsO/mq3v6kaUr6jGKztX6arZTd6D4rJ9x58L95vThVkbDTxb+Q3LQ35RqEUmbXA/MJjd9MeoNlzu/GHpjKHYZX/2DJxgt676WEDONY8hNi2SWlBpJeW3icpXS2yTf5oNgnBVUGbfDFPA6C043YrW6j/OSflZVemNUFAlJX7BG08UP11r0zNEbe2KHYJzNaCHownp08kAEYYz/ZScyuAivUF8crgghlPo1oGP3AlwF2vw64bsJFdhIIQZKaHOk5x2BmpsHcmVjI8zGlGoKdfdCyeemI0XbGxcNLea6pEifj/hfFFH54HYAO9gGa3P1rIskrCp0Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(8936002)(5660300002)(8676002)(41300700001)(66476007)(66946007)(6666004)(316002)(66556008)(44832011)(31686004)(6512007)(53546011)(6506007)(6486002)(478600001)(2616005)(26005)(83380400001)(2906002)(38100700002)(86362001)(82960400001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MnhlUTZEQVVWME9MdnNEaE5selpwVFhYZDRSTVVUYkZlSk9mOGdkQmNyOWFq?=
 =?utf-8?B?UUhvZHI4V1JXK0lLaHRRZEsvQ2x1cjIrcmpZd3pvMTNZSjYzNzhOWXY0amRm?=
 =?utf-8?B?SVRrZXFURklHWktTWnZDTmFMYWJlNW9oc2RUSTBlbWJ6VzAwVE1HRFFCb3Qw?=
 =?utf-8?B?U0tqbi8va0h4YkI4Vml2ZTI3R2k1Y0h5UWRTekZXUHZJTjVBbVUvTXA4bXBX?=
 =?utf-8?B?aGl6cWh4VHNVVkdSeXV2cG9UL1FKUFFoaVBFWjZiakxwbmxqNjRmeGM2YlVj?=
 =?utf-8?B?V0FiaUcvWStWS2lPNzdjRWVwam1oMWY0M0NYYlExVzRtQ3NFYkliMDJoSnNQ?=
 =?utf-8?B?Sy9rM2ZwTysvVDgzcFZEdmVwN055SWFHNkp3QzVCQ3ZPU1NjS2lQeEoyMU1Y?=
 =?utf-8?B?dER4SG9FTlAvc2U5SFFFSjNOQXNmbVF2QzZMdGNlRGloR1c3Z1F2cmd0SHZk?=
 =?utf-8?B?QWxpMmdVU0NtRlJNYWMySlJ3WW15WU5UMjYwUnc5MVFmNWVNMUN6WEk1OXBP?=
 =?utf-8?B?RGxJSFRQVmw2cGg0UUk4aHNUOE9kc3FUaGQxeDRFa3JvcDIrcEJvdUhKSkZV?=
 =?utf-8?B?Y1pDSDlXdW9aQzJtNlJqcDNoNm5GeHYvRlBDVzdLUitXVlc3UjRSY2xwOWlw?=
 =?utf-8?B?RGVJbGdvK0YyeCt0MHJiOVdGWmRKRDhJa0ZjS01RdnlSN2FEdUlYcHp0Y1dx?=
 =?utf-8?B?OXJSK3creFJnajUrZm1MNStqZXVrSllDemdQMUZ2Mlc4WHhrelViUEY0RDlJ?=
 =?utf-8?B?b2RlMndKUHMwZHlDM00zSDRQek5ZeWRzeW05N3BMdnVLSEVMTDRlemZYTWVQ?=
 =?utf-8?B?UVZoV0ord0dWNWZwL1ZuSlBqRjMrbnFTWVRiQTBmclNZMzlEL1dRSGR6dXE5?=
 =?utf-8?B?U211SEhSZGhOb0VjdWNCaVptSmpweDJvdkVraGxoSm1vaURqUE5oSkc2TGlh?=
 =?utf-8?B?VnR4OVg2OXJYa29WazJLVUd5dUNKWTl5blE3MnpSbFNJeXozNm41SGNISjZo?=
 =?utf-8?B?eUF0bDZKcnpoU3FpU3VUSm42WFVrWmJqMU11MGZWVGNHQVNZbE1DVk9IREpj?=
 =?utf-8?B?WVZ2YUFmNldTNnNmMHU2aWNLZUJ5VnE4aGt2RlRYWTZ0b281b0tEWWd2MkZ6?=
 =?utf-8?B?MkpFM01jeG50RWlhTWhHVFEvNk5qbmM5YjdpTFcxSnFMRE1MQ1lOVmVmalBt?=
 =?utf-8?B?TmZyeVFyT0dTSG9wN00yS2JQSW5HUHZIcnRGbGQvM2JLNnRBVjhpQ3lWd1Ns?=
 =?utf-8?B?QmZDL3NxN3hyOUIwbWVyRGNFamttWm1VelZGUGttSXd6S0tRNHhLYllaYUtN?=
 =?utf-8?B?UlRuUzRrc1ZrcUpnbW0yQnp5RG9JVnNFY0hUcEhZWVNSeEpmVVZlM3RvTDNV?=
 =?utf-8?B?NW8xK0VZaTZnK1BMZ1B3WU9KekJ0ZmIvMDRjcmdBS2NVck9zc0NseWtJZERM?=
 =?utf-8?B?VEZiaEczVTI4alpoODFUT0FVcHhHbkJJSHovM2xJK1hHclYreFNITngvVjV0?=
 =?utf-8?B?RFJQQXRJVFhsRlNhV3pBTVA0U0xLYTlNUGEwQmtwY2QyUzRUU1J3MUVMYVMz?=
 =?utf-8?B?Y0x0SjZDd01nSm85eE9iRFh0c3dscHFNdVNzL0h4RTVicjlwZE5oT1pGZTUr?=
 =?utf-8?B?YjNMQ29YT1Q0R2Z1TGhXTk5OQmxFZm5PUzB2ZlFodmhnaVloQnJlcHlqbFdn?=
 =?utf-8?B?cWhGbGVyUXFQYTROMHpYaFFxSjl5ZVpiTHgyVys0KzZjcHBBRkRWTXpRd2Jx?=
 =?utf-8?B?WEh1b0JQOFg4UFhvY3lJOEd4clhqWFBLcUNJQXZTWERGVVRRbFF5cDZUUmI4?=
 =?utf-8?B?MFd0V2NjbmY5RHFiRUt2cm5Rdmk1Tk85aDF1U2NQNkxZc1I1RmhSU0wyaDhz?=
 =?utf-8?B?eWhuQ1htK2J4ZENlOVdpaE40a3l4b0YvOEVUUFIrRitVUHUrbjlNMTZPMHRx?=
 =?utf-8?B?TkJnSUhlVjVvT21vSlpZTXNYdzgzN0JvMnljeElOYXh0RXA1VWljQ3NNaFZt?=
 =?utf-8?B?V1oxRVlPQzQ4aTJqMSswMDZ0ZWVhb1lNT0ZLeGZqV0hnTjZ0MmRzSnZnd3pv?=
 =?utf-8?B?Q29uYWFSV1pjVXZPMmcwV3ZKY3FpRkFUZVYxSkdWMDNTMVRrVTQ3MGFtSzhG?=
 =?utf-8?Q?L0+p2biNHI5/5+LmQv0604hpu?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cba7f89c-ecb4-455b-9a8b-08dbf232713c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 05:57:46.7975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQUUo8oRs3nZzJ7Z0ffDzo1jF+fs0EIXXK2BB8+i+f2YE65rwyFzQc9ScHA87njcALqRCcouKikUbpz+kujQHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5751
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Dec 2023 05:57:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13766

On 24.11.23 22:12, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows to use third party service to sign the swupate packages
> during build.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  classes/swupdate.bbclass                            | 13 +------------
>  .../swupdate-certificates/files/sign-swu-cms        |  9 +++++++++
>  .../swupdate-certificates/files/sign-swu-rsa        |  6 ++++++
>  .../swupdate-certificates-key.inc                   | 12 +++++++++---
>  4 files changed, 25 insertions(+), 15 deletions(-)
>  create mode 100644 recipes-devtools/swupdate-certificates/files/sign-swu-cms
>  create mode 100644 recipes-devtools/swupdate-certificates/files/sign-swu-rsa
> 
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index 38c2e0a..117f9fe 100644
> --- a/classes/swupdate.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -120,18 +120,7 @@ IMAGE_CMD:swu() {
>              fi
>              echo "$file"
>              if [ -n "$sign" -a "${SWU_DESCRIPTION_FILE}" = "$file" ]; then
> -                if [ "${SWU_SIGNATURE_TYPE}" = "rsa" ]; then
> -                    openssl dgst \
> -                        -sha256 -sign "/usr/share/swupdate-signing/swupdate-sign.key" "$file" \
> -                        > "$file.${SWU_SIGNATURE_EXT}"
> -                elif [ "${SWU_SIGNATURE_TYPE}" = "cms" ]; then
> -                    openssl cms \
> -                        -sign -in "$file" \
> -                        -out "$file"."${SWU_SIGNATURE_EXT}" \
> -                        -signer "/usr/share/swupdate-signing/swupdate-sign.crt" \
> -                        -inkey "/usr/share/swupdate-signing/swupdate-sign.key" \
> -                        -outform DER -noattr -binary
> -                fi
> +                sign-swu "$file" "$file.${SWU_SIGNATURE_EXT}"
>                  # Set file timestamps for reproducible builds
>                  if [ -n "${SOURCE_DATE_EPOCH}" ]; then
>                      touch -d@"${SOURCE_DATE_EPOCH}" "$file.${SWU_SIGNATURE_EXT}"
> diff --git a/recipes-devtools/swupdate-certificates/files/sign-swu-cms b/recipes-devtools/swupdate-certificates/files/sign-swu-cms
> new file mode 100644
> index 0000000..7bd04ef
> --- /dev/null
> +++ b/recipes-devtools/swupdate-certificates/files/sign-swu-cms
> @@ -0,0 +1,9 @@
> +#!/bin/sh
> +in_file=$1
> +out_file=$2
> +openssl cms \
> +	-sign -in "$in_file" \
> +	-out "$out_file" \
> +	-signer "/usr/share/swupdate-signing/swupdate-sign.crt" \
> +	-inkey "/usr/share/swupdate-signing/swupdate-sign.key" \
> +	-outform DER -noattr -binary
> diff --git a/recipes-devtools/swupdate-certificates/files/sign-swu-rsa b/recipes-devtools/swupdate-certificates/files/sign-swu-rsa
> new file mode 100644
> index 0000000..fad3004
> --- /dev/null
> +++ b/recipes-devtools/swupdate-certificates/files/sign-swu-rsa
> @@ -0,0 +1,6 @@
> +#!/bin/sh
> +in_file=$1
> +out_file=$2
> +openssl dgst \
> +	-sha256 -sign "/usr/share/swupdate-signing/swupdate-sign.key" "$in_file" \
> +	> "$out_file"
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> index 1b6b6dd..0b3e045 100644
> --- a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> @@ -14,16 +14,22 @@ inherit dpkg-raw
>  PROVIDES += "swupdate-certificates-key"
>  
>  SWU_SIGN_KEY ??= ""
> -
> +SWU_SIGN_SCRIPT ??= "sign-swu-cms"
>  SRC_URI:append = " ${@ "file://"+d.getVar('SWU_SIGN_KEY') if d.getVar('SWU_SIGN_KEY') else '' }"
> +SRC_URI:append = " ${@ "file://"+d.getVar('SWU_SIGN_SCRIPT') if d.getVar('SWU_SIGN_SCRIPT') else '' }"
>  
> +do_install[cleandirs] = "${D}/usr/share/swupdate-signing/ \
> +                         ${D}/usr/bin/"
>  do_install() {
> +    if [ ! -f ${WORKDIR}/${SWU_SIGN_SCRIPT} ] ]; then
> +        bbfatal "You must add a '${SWU_SIGN_SCRIPT}' to execute the signing process"
> +    fi
> +    install -m 0700 ${WORKDIR}/${SWU_SIGN_SCRIPT} ${D}/usr/bin/sign-swu
>      if [ -z ${SWU_SIGN_KEY} ] ]; then
>          bbfatal "You must set SWU_SIGN_KEY and provide the required file as artifacts to this recipe"
>      fi
>      TARGET=${D}/usr/share/swupdate-signing/
> -    install -d -m 0700 ${TARGET}
> -    install -m 0700 ${WORKDIR}/${SWU_SIGN_KEY} ${TARGET}/swupdate-sign.key
> +    install -m 0600 ${WORKDIR}/${SWU_SIGN_KEY} ${TARGET}/swupdate-sign.key
>  }
>  
>  do_prepare_build:append() {

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


