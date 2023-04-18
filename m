Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3300C77B75
	for <webhook@archiver.kernel.org>; Tue, 18 Apr 2023 17:07:54 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.60])
 by mx.groups.io with SMTP id smtpd.web11.15405.1681837668245401178
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Apr 2023 10:07:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=u+hi+B4j;
 spf=pass (domain: siemens.com, ip: 40.107.20.60, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ho1EDdvsrbyJ3j8zW3C8ZqKXZh/uNtUblRvZfjrnK4TH9WgXsWKHqt7dmfq4k0jDJWk8XmOdcR9Y4yoJvYBGLvjpPMOlKumiGRYBOSvRQ33Q66Np1V90HhTFN0Kl+Jv8+DY234hMwoNFImN3a5fGcr9VfhiKpmtglJ6cZwDpb6FDNtT01R8xNkF1MTEwIWWgRAIRahXb3SITH4t4G/C6FhSSYqzIsjX4IPYmsBzT+614qKQLA9V9EAKC4L848VLfCD+hrcJuJI6LpUxArZDLCFPbMm/pOXY24toPUWkXX7udgtj9zDhKgsh6g1ttOKsyye57Ucu3/xU9vOdorjHUxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iU+N38ESc+MG0F20lEHw1dQb6o+caAFHt4aGENOlUV0=;
 b=O8ugnT1XDQ4aboghqYOkzuhSouEOBeQB48CqyaLrEWPizsQkYCNx9tXqkeg6XaQrbc5vkxdXTrwtNiZyDuVVSqYJZbhiygzXvMQpXCbj3YdTv0Z1wryltEwxty7K31eAWLWu/CBzhFNFP/GId2gRK0sdRg2S3yKPPykYKMTOUHgv2MMjD2MGzbPDv7+bgUq/jcLEfC3Cp0LGC4ibj/jHRkH6FZGX84VnJxpO3sMT1Sw3YLzcR81WU4wwPMJMhONBRGtmy874JejhK0adb9oEihW2zBfsiEZlVpaoBYx4ceAI7b9u/a7VDjn/dLPP03ymEoeKokG9ocaT09BUKhh/FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iU+N38ESc+MG0F20lEHw1dQb6o+caAFHt4aGENOlUV0=;
 b=u+hi+B4j+1YA1MwzvVUsAfnqikH1gQ8hnalVjy0dUFJiAducZnLXkKVe/a600u3fGOJCdsmOuJQ+5ZSbFgA6IROAO9QoqlB2sb3y81SrmkG7POsZySQ2xzec9aLUvc92Xdx8yAdvjs4gvhKXMefnYgzvN7S2EOeKl1Dor7R7QLEyefJ8yhM3SIIC0iNughRWtiXma5St0sCiKXM7mjPzSBpiTZolTDckr801AuH6PsoYB9oYbFP/zn72vXEIesGKVO4fHIaLqjtANGN0h7bTjJ78XSYxvbVeUxGpm/g5qeD3nCZ/k/N6lzz9e7XbB163hYarTc12NdA0mUJOauaEaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5411.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:32a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Tue, 18 Apr
 2023 17:07:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.019; Tue, 18 Apr 2023
 17:07:44 +0000
Message-ID: <0d61fba1-c40a-b2e4-4f44-cd50441b5b0f@siemens.com>
Date: Tue, 18 Apr 2023 19:07:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [cip-dev][isar-cip-core][PATCH v3] efibootguard: use debian
 folder from salsa
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20230417120431.356950-1-Quirin.Gylstorff@siemens.com>
 <3354e3b1-9cb2-aedd-0284-586dc8e77ed1@siemens.com>
In-Reply-To: <3354e3b1-9cb2-aedd-0284-586dc8e77ed1@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5411:EE_
X-MS-Office365-Filtering-Correlation-Id: b85f0ead-55be-41de-ce9c-08db402f6cc9
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xkr8DsIBwJVzk/DEVe+hU0EgLpAT/mmpvbrutbd7THYEdUa8Yxw5cUTGq41qzlvSY9g3HwA8vqENGig1NQnj9vm9HNQxYb9YPekFpLtGjYCG9YF+Vq52U0D7ZDK0p4nUigmxwdiiz4qTt1wKvQqS7kenEG4BKrtZiojs/S6WzBhIYBLEsvYS2tLeftqlzBoV2T60t0pDNYew/78Zh4KVSbolNmnmvMZyuZ3mfgv99AydBs4vLlrV18sSFPuvUdjrFz674HtJ1HP3YrJbxMx7ERMmldw9mQX54IIPAvsCC6vDUJ0mWZLvf4hTLd60+qbMsQcT+P6xByOfzI9U7/AtlW9FWc1jd9E4BXbiX+qN3EE53j8mZBCGD1DVm5eO2gNS0aJyQYABxINAe0wKoI1uMU7kKQEvdNnDRn0ygPo7x0OcZgAd/qrZRH9dpUFogScmEMKSBQar7zZ9X3mJ85t1YSPy6IWgoxlIxvXk58BZV4/ZsS7RKzeyqEH82uMF60bS3eNUMFEswHxdG2g5zhnBgjNzo9+5jXU0h3iDNdvic46V0nvDca0b1T9y0XK+L6JGbyz2dYYWfJVmuZNgAOkM4wI3STRjeDyI/58I+geXwDV4CSDB9iid6J9jj+6KugEel7QqxSbr3+oeEyEGjHgr1iZrkNLFKHxGa4ODi0rhWx3/3FvqOur0B6xMd//r8E9w
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199021)(66556008)(8676002)(41300700001)(316002)(66946007)(66476007)(44832011)(2906002)(82960400001)(30864003)(8936002)(5660300002)(83380400001)(6506007)(26005)(186003)(53546011)(2616005)(6512007)(966005)(478600001)(6486002)(6666004)(38100700002)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UlQyQlp3K3NjOWh3bVRidjAvME1zZnptKzRjaEhHcS82dVZ6ZitiTW1HZ1ZM?=
 =?utf-8?B?YlFIS0twU2lMQkJVVFR0QnM2cmF6MTMwUnFCK0RqWTcwYll5SmM4MU1xT25C?=
 =?utf-8?B?a0RObWVJOUQ2MmUzbDFGWjVsc29oeURGY2xPbXFESzhZeHVvWlM0akdEUWhM?=
 =?utf-8?B?QkROUjhTWnhnQWhKMzRrMkQ5UnpFNWh1Q3RLV2UyM2VzOFdpZWFMbzhEdHF1?=
 =?utf-8?B?TVpnVWkrMHRkU1hHR3lRejJ1dEllU2h5NEpSR2JPTHN3YlVmaVMzcFZyS3RH?=
 =?utf-8?B?Ui9HR3p0NE9FYVZxV1VEU2I5NGdDOWtuK21RRzBTWEp0T1BSeDdEb08vd3lp?=
 =?utf-8?B?V2IzMThBKzQ1N1ViU05CWExkejhrZ3J3ODdqdVVJUk1lUkx6cnJkNUh3RUVU?=
 =?utf-8?B?M2kwaFRqNTRQZk96QU1OMFYrYnREV3IwV2NJdEZGeUdLNW94OTJMZFZncElr?=
 =?utf-8?B?bjl3OVhZeXhJVDlydlhweWZvQ0JMT0JqeUdVUnBsazBoaDlTamZJSG5xbnZ5?=
 =?utf-8?B?cEFhVkRaUzdoS0xuYThqQU5oa083OTdZQnNic2ZaTFRuaXJiSXQwNXl3Qm5i?=
 =?utf-8?B?OVF6aGJBdkl0cWFhdFZLczduWERCeDB2T3JVbk43cTJ2YURHOVVKeTVhbTlx?=
 =?utf-8?B?cXFHWlAzWjFKTUg5WHV1SzQxbTJhZ1gybjZSR0RyYnpXUVlRMkVIMFNsMllM?=
 =?utf-8?B?RGZaODM3V1BVYVVFZ0FSSEsybnlVZlhhVVptUVZXY1ZYQldqbU5qbXRCcDBa?=
 =?utf-8?B?OXVvMjJyWjFoWS9uS2FMbVJhbWJ2R09sWVMzWHUyOTA5c1Y2MTNGK1RHZVFl?=
 =?utf-8?B?a3RCUDVJRDRITzhVdlp5dnJGQW9uRFEwWVkyNnR6alhPUGZxdlZVMU1TTnpq?=
 =?utf-8?B?dUs0YjFaMS9rZHl0RDJEZkxRSWNrc1NQMGFVU2R4T0NEM0I0b2NMSDdWdGxi?=
 =?utf-8?B?WUpQbEtvWTlZVG9FeC91b3dlMlJoMThmeDBFaWpUMUQ4QmUwajBNZmwyMUtQ?=
 =?utf-8?B?MHl5YTJRYU50STI4c01lUXFaT1p5aEpzQ0lmbG5jM2xRaGtmdTZyU1VlS3kr?=
 =?utf-8?B?WGFRaGtJVHlNYTVHcXFvM1p6OTd4MG56WnUxZFdqSW40QUVyR1YyeE5GdUpJ?=
 =?utf-8?B?OGgwOFJiQU4rei9IMXIxZU9SaHl6WndnMXE2cU1QMHN3YVhpcmxBL2ROVkFh?=
 =?utf-8?B?bk9YSjJCU3ZWSDhIb09KSTM3Nm81MHBkcktvdlZmTFZWek5RQjBVRXAzNkF4?=
 =?utf-8?B?T0I4amREL1J6c21kbTF2SjZZWklNNjFkRkNibDNOMDhFcWpMcjJSRTc5dzc5?=
 =?utf-8?B?VzNRYmdJd1JSenk3RkNMeVozVVUraHFvUTRpdVF3QUs0ZVpUYzFTYU56a2JL?=
 =?utf-8?B?WlFKbEpPalhPbUpjR2hOZm5EdXlxNmc1bjlNUnR3Snh1TE5qY1FjQ1Y2Zy9W?=
 =?utf-8?B?eDZUaE9lajU5Z1JIRnRyUmNuMzRoZTg1RU1MMXNMTjQzZzNBRXMzSXZ1ZWVP?=
 =?utf-8?B?NmxMR1ZVRWNmWnBzZU5SOVNNYWFtQ2YzSS9hR3p5WUd1STg5LzE5dXRtdTU5?=
 =?utf-8?B?dzJ5RVJabTduSFo2MWRyczlVR0RDTHVLcXUrSjdHSkxVNCtab1NKbUxtaUta?=
 =?utf-8?B?K25GSytjOTlXbmlFUExqaUpoNllwejdLSnpZdm8vT3h3OWE0TmN1SFBsWXVO?=
 =?utf-8?B?N2NERnFrMXo2dFdmRW1UeTUvUTBGTXhFZlQzdkVjQzA4eGR0aEZ1VzNtUTZq?=
 =?utf-8?B?Wi9CMDl6Tzl6dWFHZGFmNm1ybThzY0lnSlY2aW5OZzhucnZWNDk0OU9IR2Nj?=
 =?utf-8?B?blRsYThsT3JyZEFGQ0syZnNrUXVHYkV6N2VvTXc3a3cyMmN0KzZrM0ltbFZZ?=
 =?utf-8?B?T1Q5OGpaQWVPRGlxMWRzeklrZW9uQ093TDhHRE5rcUhxbjBMS1ErMi9EMmJH?=
 =?utf-8?B?K3cya09jTS92Y0d5cTh5UHF2eXJ2QmJhTzZBWGY1eGtFTW1keWlRYkdIQVVD?=
 =?utf-8?B?VTN4em5SRVMxVUVmKzZ6aGJ1Z1dEUGhhbjJoVTB4UzV5QnZ6N0NNbjFFM1pX?=
 =?utf-8?B?anVaajhycXA0dGxkb0VPVy80eEl0VUZSUENKZlNDWC8wN3l5RU9HY2hKYXNF?=
 =?utf-8?Q?C7gj2+rqrRIYyOA4r3Q+eJ0IJ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b85f0ead-55be-41de-ce9c-08db402f6cc9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 17:07:43.7385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vC30f2LoVzFrxsgxJGE9yJwNwcaOb78G3LBaXFKNXpr9Q4PPoqY21bP7hkT1Nh6r4TsDj71GEYsS/ifvFzBwCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5411
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Apr 2023 17:07:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11228

On 17.04.23 20:39, Jan Kiszka wrote:
> On 17.04.23 14:04, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> To avoid package name conflicts between cip-core and Debian upstream
>> use the debian folder from upstream to build efibootguard.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>> Changes v2:
>>  - rebase onto next 
>>  - always build efibootguard 
>>
>> Changes v3:
>>  - resend only efibootguard as patch "Enable Images based on Debian 12 (bookworm)" is already deployed
>>  - rebase onto next
>>  - remove unnecessary patch 0002-d-control-remove-native-from-python3-shtab.patch
>>
>>  ...guard_0.13.bb => efibootguard_0.13+cip.bb} | 30 +++++++++-------
>>  ...l-Make-compatible-with-debian-buster.patch | 36 +++++++++++++++++++
>>  recipes-bsp/efibootguard/files/debian/compat  |  1 -
>>  .../efibootguard/files/debian/control.tmpl    | 20 -----------
>>  .../debian/efibootguard-dev.install.tmpl      |  2 --
>>  .../files/debian/efibootguard.install         |  5 ---
>>  recipes-bsp/efibootguard/files/debian/rules   | 15 --------
>>  ...01-add-machine-type-name-for-riscv64.patch |  0
>>  recipes-core/images/efibootguard.inc          |  5 ---
>>  recipes-core/images/swupdate.inc              |  6 ++--
>>  recipes-core/swupdate/swupdate.inc            |  2 +-
>>  11 files changed, 57 insertions(+), 65 deletions(-)
>>  rename recipes-bsp/efibootguard/{efibootguard_0.13.bb => efibootguard_0.13+cip.bb} (55%)
>>  create mode 100644 recipes-bsp/efibootguard/files/debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch
>>  delete mode 100644 recipes-bsp/efibootguard/files/debian/compat
>>  delete mode 100644 recipes-bsp/efibootguard/files/debian/control.tmpl
>>  delete mode 100644 recipes-bsp/efibootguard/files/debian/efibootguard-dev.install.tmpl
>>  delete mode 100644 recipes-bsp/efibootguard/files/debian/efibootguard.install
>>  delete mode 100755 recipes-bsp/efibootguard/files/debian/rules
>>  rename recipes-bsp/efibootguard/files/{ => src-patches}/0001-add-machine-type-name-for-riscv64.patch (100%)
>>
>> diff --git a/recipes-bsp/efibootguard/efibootguard_0.13.bb b/recipes-bsp/efibootguard/efibootguard_0.13+cip.bb
>> similarity index 55%
>> rename from recipes-bsp/efibootguard/efibootguard_0.13.bb
>> rename to recipes-bsp/efibootguard/efibootguard_0.13+cip.bb
>> index dd76198..d61c080 100644
>> --- a/recipes-bsp/efibootguard/efibootguard_0.13.bb
>> +++ b/recipes-bsp/efibootguard/efibootguard_0.13+cip.bb
>> @@ -16,25 +16,29 @@ LICENSE = "GPL-2.0"
>>  LIC_FILES_CHKSUM = "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=751419260aa954499f7abaabaa882bbe"
>>  MAINTAINER = "Jan Kiszka <jan.kiszka@siemens.com>"
>>  
>> +
>>  SRC_URI = " \
>> -    https://github.com/siemens/efibootguard/archive/refs/tags/v${PV}.tar.gz;downloadfilename=efitbootguard-v${PV}.tar.gz \
>> -    file://debian \
>> +    https://github.com/siemens/efibootguard/archive/refs/tags/v0.13.tar.gz;downloadfilename=efibootguard_0.13.orig.tar.gz;unpack=0;name=tarball \
>> +    git://salsa.debian.org/debian/efibootguard.git;protocol=https;branch=master;name=debian \
>> +    file://debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch \
>>      "
>> -SRC_URI[sha256sum] = "639a6d8f687cb099b2e9b01eb08ad1494267fe26b5d903b4d405d0737feb989b"
>> +SRC_URI[tarball.sha256sum] = "639a6d8f687cb099b2e9b01eb08ad1494267fe26b5d903b4d405d0737feb989b"
>> +SRCREV_debian = "78a14cbde6ac1d2132a61bddbea7cf39b661d82a"
>> +
>>  # add riscv64 support
>> -SRC_URI += "file://0001-add-machine-type-name-for-riscv64.patch"
>> +SRC_URI += "file://src-patches"
>> +
>>  CHANGELOG_V = "${PV}+cip"
>>  
>> -PROVIDES = "${PN}"
>> -PROVIDES += "${PN}-dev"
>> +PROVIDES = "libebgenv-dev libebgenv0 efibootguard"
>>  
>> -DEPENDS = "python3-shtab"
>> -BUILD_DEB_DEPENDS = "debhelper,autoconf-archive,check,gnu-efi,libpci-dev,pkg-config,python3-shtab,zlib1g-dev"
>> -BUILD_DEB_DEPENDS:append:amd64 = ",libc6-dev-i386"
>> -BUILD_DEB_DEPENDS:append:i386 = ",libc6-dev-i386"
>> +S = "${WORKDIR}/git"
>> +
>> +PATCHTOOL = "git"
>>  
>>  inherit dpkg
>>  
>> +DEPENDS = "python3-shtab"
>>  # needed for buster, bullseye could use compat >= 13
>>  python() {
>>      arch = d.getVar('DISTRO_ARCH')
>> @@ -43,10 +47,10 @@ python() {
>>          d.setVar('DEB_HOST_MULTIARCH', proc.read())
>>  }
>>  
>> -TEMPLATE_FILES = "debian/control.tmpl debian/efibootguard-dev.install.tmpl"
>> -TEMPLATE_VARS += "DESCRIPTION_DEV BUILD_DEB_DEPENDS DEB_HOST_MULTIARCH"
>> +CHANGELOG_V = "<orig-version>+isar"
>>  
>>  do_prepare_build() {
>> -    cp -R ${WORKDIR}/debian ${S}
>>      deb_add_changelog
>> +    cd ${S}/debian
>> +    quilt import ${WORKDIR}/src-patches/*.patch
>>  }
>> diff --git a/recipes-bsp/efibootguard/files/debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch b/recipes-bsp/efibootguard/files/debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch
>> new file mode 100644
>> index 0000000..844eae4
>> --- /dev/null
>> +++ b/recipes-bsp/efibootguard/files/debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch
>> @@ -0,0 +1,36 @@
>> +From 299b2fecb4be67b3b669762a88cb3376a9fd5628 Mon Sep 17 00:00:00 2001
>> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +Date: Tue, 14 Feb 2023 10:30:34 +0100
>> +Subject: [PATCH 1/2] d/control: Make compatible with debian buster
>> +
>> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +---
>> + debian/compat  | 1 +
>> + debian/control | 2 +-
>> + 2 files changed, 2 insertions(+), 1 deletion(-)
>> + create mode 100644 debian/compat
>> +
>> +diff --git a/debian/compat b/debian/compat
>> +new file mode 100644
>> +index 0000000..9a03714
>> +--- /dev/null
>> ++++ b/debian/compat
>> +@@ -0,0 +1 @@
>> ++10
>> +\ No newline at end of file
>> +diff --git a/debian/control b/debian/control
>> +index fa7867c..8b92019 100644
>> +--- a/debian/control
>> ++++ b/debian/control
>> +@@ -2,7 +2,7 @@ Source: efibootguard
>> + Section: admin
>> + Priority: optional
>> + Maintainer: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +-Build-Depends: debhelper-compat (= 13),
>> ++Build-Depends: debhelper,
>> +  autoconf-archive,
>> +  check,
>> +  gnu-efi,
>> +-- 
>> +2.39.1
>> +
>> diff --git a/recipes-bsp/efibootguard/files/debian/compat b/recipes-bsp/efibootguard/files/debian/compat
>> deleted file mode 100644
>> index ec63514..0000000
>> --- a/recipes-bsp/efibootguard/files/debian/compat
>> +++ /dev/null
>> @@ -1 +0,0 @@
>> -9
>> diff --git a/recipes-bsp/efibootguard/files/debian/control.tmpl b/recipes-bsp/efibootguard/files/debian/control.tmpl
>> deleted file mode 100644
>> index 626d43f..0000000
>> --- a/recipes-bsp/efibootguard/files/debian/control.tmpl
>> +++ /dev/null
>> @@ -1,20 +0,0 @@
>> -Source: ${PN}
>> -Section: base
>> -Priority: optional
>> -Standards-Version: 3.9.6
>> -Build-Depends: ${BUILD_DEB_DEPENDS}
>> -Homepage: ${HOMEPAGE}
>> -Maintainer: ${MAINTAINER}
>> -
>> -Package: ${PN}
>> -Depends: ${shlibs:Depends}, python3:any
>> -Section: base
>> -Architecture: ${DISTRO_ARCH}
>> -Priority: required
>> -Description: ${DESCRIPTION}
>> -
>> -Package: ${PN}-dev
>> -Section: base
>> -Architecture: ${DISTRO_ARCH}
>> -Priority: optional
>> -Description: ${DESCRIPTION_DEV}
>> diff --git a/recipes-bsp/efibootguard/files/debian/efibootguard-dev.install.tmpl b/recipes-bsp/efibootguard/files/debian/efibootguard-dev.install.tmpl
>> deleted file mode 100644
>> index 948019a..0000000
>> --- a/recipes-bsp/efibootguard/files/debian/efibootguard-dev.install.tmpl
>> +++ /dev/null
>> @@ -1,2 +0,0 @@
>> -include/ebgenv.h usr/include/efibootguard
>> -libebgenv.a usr/lib/${DEB_HOST_MULTIARCH}
>> diff --git a/recipes-bsp/efibootguard/files/debian/efibootguard.install b/recipes-bsp/efibootguard/files/debian/efibootguard.install
>> deleted file mode 100644
>> index 01cf974..0000000
>> --- a/recipes-bsp/efibootguard/files/debian/efibootguard.install
>> +++ /dev/null
>> @@ -1,5 +0,0 @@
>> -usr/bin
>> -usr/lib/*/efibootguard/kernel-stub*.efi
>> -usr/lib/*/efibootguard/efibootguard*.efi
>> -usr/lib/*/libebgenv.so.0*
>> -usr/share/efibootguard/completion
>> diff --git a/recipes-bsp/efibootguard/files/debian/rules b/recipes-bsp/efibootguard/files/debian/rules
>> deleted file mode 100755
>> index 9c3b916..0000000
>> --- a/recipes-bsp/efibootguard/files/debian/rules
>> +++ /dev/null
>> @@ -1,15 +0,0 @@
>> -#!/usr/bin/make -f
>> -export DH_VERBOSE=1
>> -export DEB_BUILD_MAINT_OPTIONS=hardening=+all,-stackprotector
>> -include /usr/share/dpkg/pkg-info.mk
>> -
>> -override_dh_auto_test:
>> -	# we do not run the tests; that avoids having to pull the fff submodule
>> -
>> -override_dh_installchangelogs:
>> -	# we're not interested in changelogs
>> -
>> -override_dh_installdocs:
>> -	# we're not interested in docs
>> -%:
>> -	dh $@ --with autoreconf
>> diff --git a/recipes-bsp/efibootguard/files/0001-add-machine-type-name-for-riscv64.patch b/recipes-bsp/efibootguard/files/src-patches/0001-add-machine-type-name-for-riscv64.patch
>> similarity index 100%
>> rename from recipes-bsp/efibootguard/files/0001-add-machine-type-name-for-riscv64.patch
>> rename to recipes-bsp/efibootguard/files/src-patches/0001-add-machine-type-name-for-riscv64.patch
>> diff --git a/recipes-core/images/efibootguard.inc b/recipes-core/images/efibootguard.inc
>> index bb1aa1d..cdf5558 100644
>> --- a/recipes-core/images/efibootguard.inc
>> +++ b/recipes-core/images/efibootguard.inc
>> @@ -10,11 +10,6 @@
>>  #
>>  
>>  IMAGE_INSTALL:append = " efibootguard"
>> -IMAGE_PREINSTALL:append:sid = " efibootguard"
>> -IMAGE_PREINSTALL:append:bookworm = " efibootguard"
>> -IMAGE_INSTALL:append:bullseye = " efibootguard"
>> -IMAGE_INSTALL:append:buster = " efibootguard"
>> -
>>  WIC_IMAGER_INSTALL:append = " efibootguard:${DISTRO_ARCH}"
>>  WDOG_TIMEOUT ?= "60"
>>  WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE DTB_FILES"
>> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
>> index 817fce0..ebc844a 100644
>> --- a/recipes-core/images/swupdate.inc
>> +++ b/recipes-core/images/swupdate.inc
>> @@ -12,9 +12,9 @@
>>  inherit image_uuid
>>  inherit read-only-rootfs
>>  
>> -IMAGE_PREINSTALL:append:sid = " swupdate"
>> -IMAGE_PREINSTALL:append:bookworm = " swupdate"
>> -IMAGE_INSTALL:append:bullseye = " swupdate"
>>  IMAGE_INSTALL:append:buster = " swupdate"
>> +IMAGE_INSTALL:append:bullseye = " swupdate"
>> +IMAGE_PREINSTALL:append:bookworm = " swupdate"
>> +IMAGE_PREINSTALL:append:sid = " swupdate"
>>  
>>  IMAGE_INSTALL += " swupdate-handler-roundrobin"
>> diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
>> index 53b8133..e5e7282 100644
>> --- a/recipes-core/swupdate/swupdate.inc
>> +++ b/recipes-core/swupdate/swupdate.inc
>> @@ -26,7 +26,7 @@ DEB_BUILD_PROFILES += "${@get_bootloader_build_profile(d)}"
>>  def get_bootloader_dependencies(d):
>>      bootloader = d.getVar("SWUPDATE_BOOTLOADER") or ""
>>      if bootloader == "efibootguard":
>> -        return "efibootguard-dev"
>> +        return "libebgenv-dev"
>>      if bootloader == "u-boot":
>>          if d.getVar("U_BOOT_CONFIG_PACKAGE") == "1":
>>              return "libubootenv u-boot-{}-config".format(d.getVar("MACHINE"))
> 
> Thanks, applied.
> 

Breaks qemu-arm64 and arm builds, see e.g.
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/4127932360.
Dropped from next again.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


