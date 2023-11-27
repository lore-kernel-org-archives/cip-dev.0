Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BE9C4167B
	for <webhook@archiver.kernel.org>; Mon, 27 Nov 2023 01:49:44 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.83])
 by mx.groups.io with SMTP id smtpd.web11.83834.1701049773859770555
 for <cip-dev@lists.cip-project.org>;
 Sun, 26 Nov 2023 17:49:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=b5xnRRy0;
 spf=pass (domain: siemens.com, ip: 40.107.8.83, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZqYz41G1R7IpLdkEkGrf5HjeAeI/vJBEk8ntSPn+URuHaJ5o8ElCdwpiJ7hMzZQ226EFWxyDAJTbrlHy6YQASlBCk3X5Cv90hwi2v5wQjAxvjj1ggPIUWAhnPMOyvh5ItXPzOmQ78dKLwv1WA4F4kRV2ksw1nvT0uT6Ycf+36NIgQpC199QYfsZBvlZTx7MKugG3z+gdJP605BoQg/R9cUK1h9Rl9B+pXqLVOkiwITaifOefZCw+kDkSQ5Y8x633jj2KDrCtKbX64AXLtFEEkkU0UOy3l8qKhomCjDrUkkEgvY0qZfZJI8qhEsyhT9d3DQR/O0KpZSY7/kgptQ1+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uzN1kYex6LBN3g6d9Yl8ywjUpKm5Dn4IrqmrwYD9oQ=;
 b=OYIY4bZOr1KJqXfKxJNJI3YkoIOS3zep+t8EPM2O3yYhK1r8EJYKp79xBUFu98HoYcFaxMK5s6mF6HA6hsCLWuMWhw8dk+Q2hWlbu8qg6TnQyY8WWAYgE157VG/+Ja7rsZgQDa8gwofNA0bzER6uXQlOOfwm+dp0M9DxAWolvrKyTijmw1AMJLfbVyozcfSrpgk05lPbcxPSVaf2/ktCWaX2OhhOD9LdHWNtZ+C5m7NB3foPTGrgdo0H6/29gxpyQwYSvCOzs9/h0UWykDfcH8TykcujBcoDkBsxCx7JrWPOZMHVKj07vS6unHgqOIxvsNwynatQo8276Mn6YX9wHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uzN1kYex6LBN3g6d9Yl8ywjUpKm5Dn4IrqmrwYD9oQ=;
 b=b5xnRRy0K2ezhr1tzzR6VIt7OKPVaKu8cSFQ4ZYjd1ju/qOofrqL38MP0oZ07ki4oXiWr3RROvtVzBWNPJ1pl9nnG8sUaUCqc3Y5McV598U0CKdSu62MIvJKFfZ76eIkSfZrBlcTJvfBYkqBxpEmWPT6tttItDiaaMPneZe1Hs7Qv6iPYWhHxI3Dq0d53WNfWnCoxU4ja/5E6gryuTVNuHyFaklsRSgdCuhxra2NKoz+ja+uAGwAo9EU9kW9SZLiD2htlpRrb7Zur2SDytCkVsDbKek52G5olifdI5LM72cAfT9Ye9C1zZ6tiEWtFtMb3RvMI/sA5qtLjvmdmpn2IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5571.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 01:49:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 01:49:30 +0000
Message-ID: <634fead5-305c-4d67-a09d-8a2e1a228cc7@siemens.com>
Date: Mon, 27 Nov 2023 09:49:23 +0800
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
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5571:EE_
X-MS-Office365-Filtering-Correlation-Id: 63002a31-340d-4094-32ef-08dbeeeb1885
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	w90cBz+DfIUOQh95z69vpYzLVOfTkwZ+F3fEoia939tAtUeSHm3I3FKL3MLFCc2yA4TRxop1vN2j2H9d2RDbM69Gw6tjaTR6faHbwl7/tfAfeQvhCn1tbJnYL5lFnM3F3jqoYBr4zz5iJTbIaTIY2Cawbcc4qgsgOXndIQr+ocvakesdYWHvGSbJHasGHxu/xI6W5HFuJrZ92ggyr4hHx8NP3slJodb5UbWSKjcnuq8QEoqJJO7naD9ZYg0SR0KfY8WXx6DdDcvmP1BvhsXmvftCvTz686va0jM/pTiKGcQ9GvBxAcuLeLuTnGN03nGxdS3IIwzCqQKB1gKspnFR6BbCe0YJdczx1j21er4An7GOVZm9Xp4XjubO2geaAMNUYpZNk4R0XRPctGXfaJNlMtHPWyZ0gudluPa9sydcOCwOel3W9vKyjXUye7UmYabvrFxWx5kBc6qOjvpAwm0rEhtpd6lpr5ZeYvx+fgLnYK+cuHJWXl/O1ZaEUkYGrxKhonnrZAOCDxCtOvZBYgb2aCNxSpxYX7fm7CCTCc55vASNTdw5uplIz/yWyJknbrBD/dMkx35ie68DQnXsEWVv+nSN8HP+OaN1fcVtK+BlBKnZBQwlHRkUg4yLtNb5DVQwZFRZa6PB+xo1EOXOnyLL8Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(366004)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(38100700002)(31686004)(82960400001)(6512007)(53546011)(6506007)(6666004)(8936002)(66946007)(66556008)(6486002)(316002)(66476007)(5660300002)(31696002)(44832011)(8676002)(478600001)(86362001)(41300700001)(2906002)(36756003)(26005)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RFF0TTRFZlFHTzRMMEFmOStnWkt3L1BhZHhCRU5FU052Q1R4eXhHUEFJV0tX?=
 =?utf-8?B?alIyNkdGd0QwanNXRjRXQm41NTVFRnZwTzBhNEJrOWFQVFFOc0U1MGJuTi9X?=
 =?utf-8?B?aVowTDMrU0daRlN0MzVoSTNqN3NDd3U0RURWS25CVnVEYUMxKzBoTUdPQVU4?=
 =?utf-8?B?U3VvWWpXdVJsMStkaDBwTXpiWmJ0cjQzZ0Q2YXFQWU5UdEZheEc3SGFlOHg2?=
 =?utf-8?B?NmJ3VUc3bzlGaHhlcVZOWmtmbHlLbmFBQ05sNXRiMitMRVNLcm93dVJGSE5o?=
 =?utf-8?B?UlAxZkNleG9NVVRoTy84K0syZTAxMkpKY2svNXZlTk9QU2xOa3EwTDlmMG0y?=
 =?utf-8?B?QjVMbVZHT3N3ZnE2Z2VwVGxzaHNUWk1SRmc0OEVjVVNXdFhTZVlVR21Yanlh?=
 =?utf-8?B?M3JaOFBGeGl5RVJrZHJQTHFnYThyaW1ZRjVrL3dsdEVlSXpKTWtlOEM5VlV3?=
 =?utf-8?B?dDNXcXpZbXZSanV6YUl0NDVYZHhKTHNPYXYxbnhQZmNFdEJ6Vk9UeGxHdWNy?=
 =?utf-8?B?aGdiNVF1dDZaSnRadTdIYStxMjhqbldBOXAzdHZxUkZ3bEsxZ2F4NXJpelcz?=
 =?utf-8?B?YXE1TGg3Ri9oeUNIMjRUTmgreUh4TndBYTQ1UkRvUklQdzZzUFplTDFWR3Mr?=
 =?utf-8?B?SmtBRDJ3SjY3NzU3MzIwWS9CcTVFSnk0TFFWZStsVWlzZEtValkvNGYxME5N?=
 =?utf-8?B?ZktwazUvYlRhb2pUdmhvd2pveE1zcFlOaGJXRzVJek5nUXI3ZndHM1VCUVps?=
 =?utf-8?B?eWttbTZqT05yN3RkSVZDTnczVU1PdlhjWldDek5RdXI0eEFvOVFCOE9qeVA1?=
 =?utf-8?B?L1h1NVBpODh0U09KUnovNGs5bnZ3a24vZTJwSTFrRmwzcGt1aE9zekJPY0ow?=
 =?utf-8?B?L3R5UnNEMEtCSVhHeXRUNWF4ZU1sN2lTU01MdDVzZkRScVllbis2bjJrZ1lo?=
 =?utf-8?B?WXJBeU91YWVkVmI0dU83bFRldEdDLzQrcDVaVG9NVGxiUnV3SVRIdTM1NUdD?=
 =?utf-8?B?bWlENE5weGR3cVhXYm56d2VFcUZuY0xoZVNvcmwydGRCeUgwbElabllSZDQ4?=
 =?utf-8?B?L0daMFZOb0MreTRGYXdBTFRXSExSYkpqN2tDcHUzVmE0dTlubElDZFAwMlZm?=
 =?utf-8?B?ampRajFWUXMxOHl4dFF3TWlRTld6L3dCTGRMMTZwQW42TEF2UE1Kc3FtUHAv?=
 =?utf-8?B?RHFZdW5PNzNrdTlSQ01tU2srV2VodjViS0RRYVlGTzIrUWJyVVRkSXhZdjND?=
 =?utf-8?B?b3d3NXE0YVM5UFoxaWtsREZtREZjWHRCR1R2eDdJcmtFYzl2QUkyR0FtNTJq?=
 =?utf-8?B?dkJNQXhhK1JiQzduT0p1dlRIN2JmNi9YbzJOSGN1bmQyRDBENTFyTUtMUTZJ?=
 =?utf-8?B?ejFsa3ZaUWpabGx1eVd5VU85UU44QmRkVko2cWhZQWlwQnVjcDVBREhseEpU?=
 =?utf-8?B?R0pEUCs3WmcwN2hwWGthb3Z4U0p3MWFlS0hyRVlYajViS2VKRGNPMjRVTGgy?=
 =?utf-8?B?VnRwcmE3WXJlcjZzaFJ2VklKMHJvNjc2aTQrc24wYXR3K0FGME9aaWtGSHFs?=
 =?utf-8?B?c1JVME11cU9uMmdPZ20zMk94QUhsaVRuQ2FVVlZpMk83ZklnVkd5OTY1ZjFJ?=
 =?utf-8?B?WWNsYTdBTzZqNEVlQXFseGxncGc2dVJ6VVhnNzBrMmFoamdsUnR1N253bHJo?=
 =?utf-8?B?b295cTBYV1krT0lMaDhrNEsvVzcvSXlOR3cvWVdRcnhSMzFFVXkwTTY5VE0w?=
 =?utf-8?B?RXpYNEZob2xDeHZEYk5JczVFamhIeDhpZ1oyeVlYQ2QraWhWYnZHNC96Y0JK?=
 =?utf-8?B?NGpMS1ZVa05lWXRDdzcwVENKSWJBb1cwOS9zMm1yeW5ZbUtOb0hleGZkck5z?=
 =?utf-8?B?YzcrT0R1WDdnajFON1ladFg5dmtNRkZZKzlsYnZQZGxFTHkzYXZQbzFVQ252?=
 =?utf-8?B?dW9oaVZqVCtUL1hFc1NLbVAxY1FGZm5Rb3NHUGczMmgwK1VqbklyTmIxT3dK?=
 =?utf-8?B?enVkVG1VVjB4UUtSTlJWL01GWUxYMU9PSG9LR2g1WlF5eW12UnBjNWNqZDZF?=
 =?utf-8?B?OThYOExRQk9jNVpaYzF3N3l5Wldrc21pK2tWSWhaTnZrLytNTmxqakJVdkJy?=
 =?utf-8?Q?LJYYIk/yK0DOJynOdAsvtRdqp?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63002a31-340d-4094-32ef-08dbeeeb1885
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 01:49:30.2182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +DB+jU7Rq03NwDp7ljye3i5ccOP+XGo/a3P6dbtiRuW29pUqoFakI6bCotumaaE3+3WBg5wXDBNqiFUaj5HF8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5571
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Nov 2023 01:49:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13748

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

We no longer need to set the permissions of that folder restrictively?
Practically, the key is still protected, just wondering why that was
done so far.

> -    install -m 0700 ${WORKDIR}/${SWU_SIGN_KEY} ${TARGET}/swupdate-sign.key
> +    install -m 0600 ${WORKDIR}/${SWU_SIGN_KEY} ${TARGET}/swupdate-sign.key
>  }
>  
>  do_prepare_build:append() {

Looks good to me.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


