Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF128C5475B
	for <webhook@archiver.kernel.org>; Fri,  8 Mar 2024 11:48:56 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.70])
 by mx.groups.io with SMTP id smtpd.web10.19989.1709898526576049831
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Mar 2024 03:48:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=GuFKFKoA;
 spf=pass (domain: siemens.com, ip: 40.107.21.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FK5eK4LW3ml4639O8qInWCyrhoCDXgukgBEC5Tuqvv6KhD4RUuSRsoEgWfzEVTuj8flZU27chOMN+t78vTHABDGdRFpaP77SFwZ99Zh/2hdUdx+JPrQwDbPInpyAmPTDEQ67TYRicO7s0dS84ZS7rwtLBuORmjhasWQ23xcU8eWDHJ31GTGWJOgR7zLqthAdgxWKskZlAX+1MxaEVjWdQkkgZXnpYTB5MXKCqppl8ausy8oTHmEJJm7Z38O7G/PiXu0E/MNQ8TkSsP698sMzP0AsusAdfQv/3Q79/i7zI0Ro7MPs4WLrc7/YqQlC6agc62cbxCK8KwNoTDCYQzma5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KYvwFrI4WmDNY5xWaG0uaa7DSsNhIL65tw7jhHAYu0=;
 b=Schf/ATDvPSKMMTulny1e+UZh1Gn6shzu3dzBT1aYPX6hwPWDt7TfisWwsTvIAEtwi1lgZlJuoLcr3WihFJgTrLIpUpAcV0jv61MgCw2W6Cj6ecxMSGta1Xs+X2YVwCrNMLkb7mWZkugji2VFypPq789ucoabyqqZT4S1yJjU8md99/dLL0rHJnJoqwtLSwin/8KNPaw/Z03yiuKmssaR40ow5mZSuClbqC8rpN3LeugaBVChVRoBtmChrUmF729Co7P+nTfPz0vmyBV76l7LEbgdlllt0aoXDOzYza95DjTlYtUJBfyTK9vceY2aAIJ4Gz8D8ZMYaOsQQKWhZK7zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KYvwFrI4WmDNY5xWaG0uaa7DSsNhIL65tw7jhHAYu0=;
 b=GuFKFKoA8ZN3nYwHhaASClfaxLGKy4RT9YLEOV+Z9luVMMUN6Uv5UPH6kiLEKliz28A9kVNU+uGypIZhu1KJ+1WSAU60+u4dsGlOBPJQUNQ+bnnaeD6rXY6mG67y4ZgnNm33zLn5kRPoy738FVkpsxCelL0UvUpgTO8oOei3SnSiqy9yI53UhkBik8co5CxrevPT/P0VCOKi3RyiF0UykhJMrrsB3v/xb6d4qlBX8+hEKU1RxIXdGmYFkQnLy3WupYU6BsaRKXkyA0dkGWIWzj9phx49FDfMmsq+u+zwu3OPhaEGt4roepImC/R4m6E0NrhymlTDnfE1cUbvTDoVuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7173.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 11:48:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 11:48:42 +0000
Message-ID: <797e8a35-97d3-4579-8f0d-b56a1ba09b50@siemens.com>
Date: Fri, 8 Mar 2024 12:48:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC v1 0/6] Integrate Delta Update with
 rdiff_image and delta handler
Content-Language: en-US
To: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: 0afaa56b-0df8-4e52-d2f4-08dc3f65b442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	B3v2ujQUUltSYghy2Uc+EsPocZT7x1Yu7ekQvjaUj/v36ydEbvL8KfGExPs2lAOibYFpVQx9ARj2T99yUOIUQAWRbYHlMJTO002UtqDtIkI+NfBWGZtJLiIHO5gfNJ0+bPCPnALZ6cgG43fohWsbLCrJh4JQ50JNUjRITkBHvpSKXXG6Wn2LQzoOX4bycFWsNTkhtDhvWy/roprn/MuKYFTsNMzu5n7tb/HU2MgUqXzFWJrhF7goz/EtDjgLJgCiqpw/5YWxX+l+5u5+DKPCZD7EsOQhY9SHCPBoRIQtLmNlai6Qr8HVcaZPDCCNPErglkFM4+4IzYTxHWrGfFfTrAuhOBmoL2X7KMIr3OhVkZbUObBrgZrdv9IQLOQIjBMrzLwjkeapIdrGk8d1YYSv8FJwkcuaW6BwwCJpLiZi8ewCb2j73Qf5iDf4wFQ5NOOYZlZwsqRX5s2Uxj4VqyvoieXbrrCamGbT2HPHjpYcbrGND8kDdGWUykDW2JY0BDwTlT/O6gLA2yBV2cVBfYF2ZUEEZHDBnlLuMExs8ab7WYXwwDEvA0rAVEH1yFR68HND/brsbKuGAlkVjHgUFWf9n9nGlmt321VHC7iMCG4nlZjFVrkIrm1KWaX+HZhCPQOgx3hIsQZGe6MfjdJr8X30vIqO0Vudnx6lM57JYWhjCcI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YlpXWTY5Q2QvdmQ2ME12ZTkxRlJZWnptbUZ3MkhTNUxYeVQ4NHBob0ZiKzZO?=
 =?utf-8?B?TkIxdGl0S1hJYnRoelR5TXFhMFlwc05SWmNad3psdmtRRUlsR2E2UE5pNTRK?=
 =?utf-8?B?bkpCS0JzRDdFc3liK1AxcjRLS0FHbDZnMGNkYTlXVGFoN28yN0VvQnNzV3Z4?=
 =?utf-8?B?UFdBVFVSemtUdUFHc0FERW1IcmlwQ2Nsbm8yZ1FqZXhBVHhZY3lXWTFBd0tr?=
 =?utf-8?B?dDI0V2M1eWp1aG1OWkE4bUh4bmRodXlkNlJ6dkJpREdXM3QxUXE4ME9xSGxY?=
 =?utf-8?B?OG5HU0lCeWhvd25pUTU0M3lBWUc2K3pGNVVIa0VNOGVENW05YXMvYWNPSlM2?=
 =?utf-8?B?OWpFRmgwQlRUQysrVVBTbG1Gdmc5ZE1tb21QL2pTNTVobmZTbEF3MXJkTjQy?=
 =?utf-8?B?ekZVa2xvY2lVMUFXbG1TYmdsL25xUFQ5R3pTS2s2bjRJV1V5MWdrNDQyQUVn?=
 =?utf-8?B?cXBEdlh5NGpwMjBYMlpXdkNxdXcwTThFZXNuRTlzTXdlT2RxNzhNQ0UreE1o?=
 =?utf-8?B?b21sc0ZMeElPTG9tdlVYQ1cwU2kxV28xN2tFb2F6cGx4TVN3VnF1OFVtMGFB?=
 =?utf-8?B?Q0RTTis5TnVSU3RGUmo1eEFTWFVxL2xKUWNqMkZERm5YL1BMc3AzWXJudnJv?=
 =?utf-8?B?Vk1aVUxZc1BTbXd4VWt0UmlpeTUxWmR2T014OGlVU3dKWkhTWGpsWVBVcVho?=
 =?utf-8?B?ayswRmI2SnFQUEVpQ3RSc1JtM3Y4VmN6NEF2M2RRcmx2b3R6QW9SVXNCWWNC?=
 =?utf-8?B?UVR5UUhvdUZhRElJa2pmVlFQZ3FGcE1Sc0VFQTJCQWFzK3hmQW5IRVhNK3JM?=
 =?utf-8?B?OU13SUJucjJjM1psWDdRanVQMUZlcmtIbjJPdEQ3UHR3OTNIbXZoK05zdmxT?=
 =?utf-8?B?RzlKb284c1F5clh1c2NxTDVkWmVQSUFRM0hxMituYzZxblZ2V0ZqbnZGcGJj?=
 =?utf-8?B?K09WS2JaT3JjKzZMbmMvZlA2UWNBaHlweFFidkdKRVFONHZaM205bUpFVCta?=
 =?utf-8?B?WGtqdytEaWxkQjZ5UkZ6TGN5Q3lvQ2s0ZXhqQ2ZOR1Vyd3U3U1FaT3FlV3V1?=
 =?utf-8?B?ZDhZb05vRmsxMXAwUEtLdkJsNlRvYkYvUzdUSGpiM3RRVWdPdENnTzFPSFNh?=
 =?utf-8?B?M3Y0cXJRQTA1TkZLc3RsME9OcHc3NWMyb2dnZS96aUNhbS84UjhXRGJ1dGhR?=
 =?utf-8?B?QmJXV0FEOFNSZW1za3lEOHRNVGIrcTEzUEFjUDhkWXNNRzBkVmExcFNTT3VY?=
 =?utf-8?B?aUNXVVFaMHdPTTVQYTU0dDNVNDZtNk5mZmk0aWRxTllWdko5dlJaOXpNKzhC?=
 =?utf-8?B?NEhzYWRDbDlvZFhjMjJsRjd6Y3pPd1pXQlFWb2wvQjg0RklyZ01lMWwzT1lP?=
 =?utf-8?B?cGNONThrUXBjRXdkcmJFLzkvSHhNWXNLWEtvS3IzRUl6R1JJaTk4MFRvZzUx?=
 =?utf-8?B?Q205Rm9mWVNlVUovazN0UWZGVzBiT3R5OVZLbE1FNXptbUtCbFVYZUdURHYw?=
 =?utf-8?B?OGpDaU81dkx2WVJDVmxUbGNIWmdCWmlBZlhnTmUxY0pRanJCRE1XYW9kMXVn?=
 =?utf-8?B?NmJnSmY0MnNKaHUxZ2lNdG94RkN2Yk40a2hkYkZNMTB3Nit4K20vWm1nNk42?=
 =?utf-8?B?YVB6UmtEWlpTNUlUWnUwL2t2WldUSTVuMkdqWUN0TFhOYmFWVWZJVTNYSlBW?=
 =?utf-8?B?YVRSVHRqTnBnTUtEYXVLU1lId2VOZkVTcXBiQmZJSTRQa3BpWjRMMXpZL1Jq?=
 =?utf-8?B?TUFSVnlpaXZjcFhEU0NPOHBCWnhSVHJhcC91ZUVuU3hpcENJZmNHanQrY0Z2?=
 =?utf-8?B?aWtXS3NLSFNqMzBtc1E5V2JpTTFqaVdnUFNrV2wxeW9hVWY3dHp4UnBGUFJD?=
 =?utf-8?B?Nk5TVzNKWS9Yb1B6TlNrMDg3NG9wMHZGUFprMWpubHVjanF4Uk5VZDd5b0Rm?=
 =?utf-8?B?cHFRYzhxNThlLzJIUkM3b0E4eTd4TDV6bzFtT0pFcFN4WG5IdkN2eFhGdG9u?=
 =?utf-8?B?NGRlM1JUSnRHN0tiWTZXYWo4dGFhZUFkcGR2bEt2dTI3akxxajlzUzlqWlQ3?=
 =?utf-8?B?cEg4VUFIcGt0UUUwUldtRjUwUVJrSHpHSHo0NTViZTlYTUNmSmk3RTVjWGJQ?=
 =?utf-8?B?K1VPdnFJanErbmlBMUhmdWNzTTBTNVByQ1BETDVtWVJyNTAyUFI4NmtIQ1pS?=
 =?utf-8?B?blE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0afaa56b-0df8-4e52-d2f4-08dc3f65b442
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 11:48:42.9214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FzipYRV9tzBFv+xKh/DtzvLeg0SkWXFqS8ewLNPS7SyphopzSXVkVV7sKKdsQDSRzgRGxOeLQE9iV4bejFweRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7173
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Mar 2024 11:48:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15268

On 07.03.24 08:46, Adithya Balakumar wrote:
> These series of patches enable the support for delta update for the root file system 
> with swupdate's rdiff_image and delta handler(zchunk). For now, I send this as an RFC, 
> as this needs to be reviewed by a broader audience.
>  
> A couple notes about the implementation:
> - In this patchset, Delta update is only supported for the root file system.
> - The newly added delta-update.bbclass handles the creation of the delta update artifacts.
> - The update handler type i.e rdiff_image or delta handler is set in the variable "DELTA_UPDATE_TYPE" 
> in the newly added delta-udpate.yml file along some variables required for each handler.
> - The creation of delta artifact for the rdiff_image handler requires a reference image 
> (against which the delta is computed). Currently the reference image (.wic) file is passed to the 
> build system by path to the file from the project's root directory in the variable DELTA_RDIFF_REF_IMAGE 
> in the delta-udpate.yml file.
> 
> Adithya Balakumar (6):
>   conf: Use bookworm backports for enabling delta handler in swupdate
>   swupdate-handler-roundrobin: Increase revision for Delta Handler
>     support
>   swupdate: Enable Delta handler in swupdate
>   Add Delta update support with rdiff_image and delta handler
>   swupdate.bbclass: Generate swu for delta updates
>   doc/README.swupdate.md: Update steps to test Delta software Update
> 
>  classes/delta_update.bbclass                  | 90 ++++++++++++++++++
>  classes/swupdate.bbclass                      | 35 ++++++-
>  conf/distro/cip-core-bookworm.conf            |  3 +
>  conf/distro/debian-bookworm-backports.list    |  1 +
>  ...eferences.swupdate-bookworm-backports.conf | 12 +++
>  doc/README.swupdate.md                        | 95 +++++++++++++++++++
>  kas/opt/delta-update.yml                      | 21 ++++
>  .../swupdate-handler-roundrobin_0.1.bb        |  2 +-
>  recipes-core/swupdate/swupdate_2023.05.bb     |  3 +
>  9 files changed, 259 insertions(+), 3 deletions(-)
>  create mode 100644 classes/delta_update.bbclass
>  create mode 100644 conf/distro/debian-bookworm-backports.list
>  create mode 100644 conf/distro/preferences.swupdate-bookworm-backports.conf
>  create mode 100644 kas/opt/delta-update.yml
> 

Thanks a lot for sharing! This is great step forward, even if we still
have some remarks how to make things even more user friendly.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


