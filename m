Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C447C7EE2E
	for <webhook@archiver.kernel.org>; Mon, 12 Jun 2023 06:11:31 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.55])
 by mx.groups.io with SMTP id smtpd.web11.52382.1686550282784222575
 for <cip-dev@lists.cip-project.org>;
 Sun, 11 Jun 2023 23:11:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UmLxhJsS;
 spf=pass (domain: siemens.com, ip: 40.107.20.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wgo5AH1u4cBBJV3mRAr04mTrAE74rt+24zGNEgFGBYc7wwJgIZ3zqP6kveM7DQgxIVqQDlWShvV4rbVM9GZurAyrXG0HXiSe3QZqthndJr55DIzSjKxqAQy1kNJxk/M/lKaOtvdQxuzQWC3q+fl4cbXZ02pkk7OrZUA7BdUxU26MHqUB5mqXApLrmvIhyVhC4qH6cIQpZq6GUmTymgkmPAZXx1d6EZ81vymJM3ECJFpYsQAjJU56XbTaTIxEMU6BFwAzyM+vZGQFaffepw301jz+NLXByAQJojkrvtbvuPIO9vst328i7aF1Kl/G3W/Tbabf7CcCTwBnmaB9UaVHqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7AwqfoMOmE1oPUm4gR/M75vKQ0Lan+UaHPHH3bUaps=;
 b=I7XqTaa41j0R9SUSppo13bcqHwFWEJsB/lVpd+DnAPGuQwzXRFsKfG/dbBDnMKiOJS72mwTZ1lyUnRMWTMO6wjtU/IlRnPtLs3hEyDb7XPpawbQ9gAwpOmtMD4mNVs2AFtco01jWnmbq9m2a/KRmKfdrEmO8uQDPB5Oq0zVR5XU4GNBxV4FC2K0iuDLuhFhnrtWL5BPp0z/VGPsl1qqEH19qhbDiU+XStkwqDon8D/unhfDZx4HOIEguUV52HB2aJZZQAdd5TbnXQKPluZBKtg927s7bLpWLcHN8k16ZEYzLl6mdS44Git56nv/uPs7+OvsWwEAzgF46qzIuJMl46g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7AwqfoMOmE1oPUm4gR/M75vKQ0Lan+UaHPHH3bUaps=;
 b=UmLxhJsSxmlYU/aQSWj84uIKA5tqCBTMas+M1Kl+zG8GPAd2o/pDhTSpm+YzQhl5guKDVexVxFMt/6T2ofVSn7X5Sjzd8YMFFCzyQeL+WKc65Rw6SmDteHvratN+HrFghA04Fa+kJxau9bUcDSRS7/urEv6YzXblQ6ozgoNPYueuyWJMFBtruyYFkqx+wXu7UIAZoYb66e+DyyLN3Tz7DWj+H0VgIOkpsGEoVKJ+SO7E+j0K3h8fCV9q4135OXOrOo7Z1E1Q4X0oCS4+z0XdpiUwuRjwb8Qe6/3TDW+ITpMgFbIax2emlmxQ/w6Hxd0Pym7DajUVDN/BNms+mhGWyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3481.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 06:11:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6455.037; Mon, 12 Jun 2023
 06:11:20 +0000
Message-ID: <e0825ae1-aeee-b50b-f132-bdeb795b92b9@siemens.com>
Date: Mon, 12 Jun 2023 08:11:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [isar-cip-core][PATCH] edk2-standalonemm-rpmb: Update to
 edk2-stable202305
Content-Language: en-US
To: "Su, Bao Cheng (DI FA CTR IPC CN PRC4)" <baocheng.su@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Schultschik, Sven (DI PA DCP R&D 2)" <sven.schultschik@siemens.com>
References: <e2c82aaf-5c90-778b-d324-630e5d846871@siemens.com>
 <328b3b56536af7648162e557e49a9650d83ef4d1.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <328b3b56536af7648162e557e49a9650d83ef4d1.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0448.namprd03.prod.outlook.com
 (2603:10b6:610:10e::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3481:EE_
X-MS-Office365-Filtering-Correlation-Id: c287e74d-910c-4878-8f13-08db6b0bd6ee
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZLMc0R4JuxvREekzahRVXsk7UuCquxDg1z2RHvVEC15TLQ9j+IK+ou/KE7XanBW0NDbp3zeCIJFFms2Z/jFxzz9Ss9+rYcwtuIZnb/g6tLCD/Ji1oXrBL8xVy6r8gl0Oxm+WVxPHA8sgyyNwEjQ7HbjwSKVTI7ZggbdbcOtqfYb4J+C+gkqxoILHD7S2jgOVRtVj5XKTOGN2QVzDT6Xj5W6QOKnfCD2UwfuI3JeUm6xZplRcG4mXuPYnwp7xQ/uDZnWYVGgsxDmX/0kyAK2ZHtpkrRch/E1CJzSdDF7WsZT+INwPSqEfdBmdVWZmNlZYFZxiKky+xX1p+Xf4iQGOKOxwfppoZRb/ZLoh1iffpmjI7HK6i9xJ+os/awCO+BJfvrDoLHOdbtzdnSs8yIPv9B1Ehqfv9O0cYOoxgM35QrLYUBDowAl52HC/o3xifmUzI116smPug9IUDWWCsjx0CmcpN5yrl+ynKE9R5jB+eHAJkWccUauUFhXM50jxljzVWJMpZQCKNO5XPSIbq3PlQkrJXbDz83W80IMSDLIa4a8dJPOPLXLYE1wIdgissxJWMBJ8kdPg3vZOEmMMf9us+SDnML8EZw/++tPMJMi863jELKFWU6bOds2iXky4uXyDzY51c60s+lkutBupYP9lJtaU76kPlqfmgFxNcUzoqec=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199021)(66556008)(66476007)(31686004)(66946007)(8676002)(110136005)(36756003)(8936002)(5660300002)(478600001)(4326008)(6666004)(6486002)(316002)(41300700001)(966005)(38100700002)(82960400001)(6512007)(26005)(6506007)(53546011)(186003)(44832011)(107886003)(83380400001)(2906002)(2616005)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Um1ScG8wQnZFd0s2U3RpK1NVZkZWY1I1U3BHUGhyanB2SlN2bmFuTDVVd3FQ?=
 =?utf-8?B?eHJGeTdhQ05wSXV6QmFxeTNhc3plYndibHo3M1pmay8xcktob0RFOXM3TTlY?=
 =?utf-8?B?MTR3TTZ4eXRmWEYvU1hkY09ZeFNYd21xUGg4NkZ3cWJ6UXNWZjlHWHJESFNK?=
 =?utf-8?B?eXI1RDB0Y0grZUF2bzJlK3hEZnJ5ZWwyRTZxK2FHMlI5c0lJcHZvSUU3MDQy?=
 =?utf-8?B?dTN5cGg5QitYTDUvQnI3QjlZQnBPUkE2Y3FFeldiUlpWWWJLd09LZGVsUzEx?=
 =?utf-8?B?Ui9tbEViNXNVWnVzQ0N6S2Z5b2ZIbHd2OTBMR042eGduZTVUVDEyQUg5ek5B?=
 =?utf-8?B?RVQ3Tkw5Y3BoUFBaVU1oQ0Y0K3pCWGhkVWhaTUtyYlhKWk13L0JlWVRXWHly?=
 =?utf-8?B?bk9PcjdqcG9MTFNYVU1YU202dlVoR3h1MXZpQm52MEdEaXkzMVRINFVHVU9o?=
 =?utf-8?B?SWExWlJhcGF3a3NkbjF1T3JNNW5TUitkSC81ZEFMVjRsRXorOEgwQlBjTEZt?=
 =?utf-8?B?a2ZUNVR6N2dMSUdIOG12NjhWbVlIZmNHZGluTy9CWU82TnJFTDVNdXczaGdZ?=
 =?utf-8?B?STBKdjZ4M2cwVGNISzlBWk8vWE0wR0NKRENMcUFqQ2J5dWF3dDBiRjk2SzhF?=
 =?utf-8?B?UXIraldydit3d1BEVGxqQTMzdWh5QStBVVR0ZmJGRVFIMDZQOWVMbjQvcDFl?=
 =?utf-8?B?bGpVSUpoOSt2WTlTTHlSTlY3VEdUTDNGdlZnU3VhL2hmMEp3bDU4RlR4MVZi?=
 =?utf-8?B?L2tLeWZNd05mMFdMcEFUaDFGK1hDVlRqMTBab2lUb1NlL21VbE02YkVLaEVI?=
 =?utf-8?B?MkxRaVZFaVZKaFJ2dUtXcUZUMEpqSFB1eHVTVS9XOU9YN0c1MGFxTmVYbzVL?=
 =?utf-8?B?YnkvMzVkZkt3aldDeVZZaEUxU1hxWllVSWhIbFBsZUh5VVIrbjg3RnVVSnJh?=
 =?utf-8?B?ZUdTMkdhOE1ZRXl1NGFMNklRQjJ1T0dVRWxFajBoTFR3b0FHRkdYeS9yNXNv?=
 =?utf-8?B?QWxNbjU0dFhtYXZOM1I3dGJOejYrUlJZMklVbFVuZVliMzhyQUhqZlNxOWNl?=
 =?utf-8?B?OHlVVWgyNmx6WlJvRWlFMVN3TUhEdExXZURLS1dPMGltWExNZi9KOTk1Zm1Y?=
 =?utf-8?B?MlNPNEJXTDFTakhBN29QaUhzUGFEc082ZnpFcER0OTRIWnFyOVZ6YzNtRmNz?=
 =?utf-8?B?QkRXMURyWmJTVHRZS0o3NjBRbWsrQlVVTW02WG95WnpJWXpoRE9TSU1FUFk0?=
 =?utf-8?B?TWc3ekpXVStTeW9EWGJRZ0F3dDFaSXl6VEV6R0NoUXZyaldaVUk5RG0rRk9t?=
 =?utf-8?B?eWZqT3BVRFJnYld1dG9hY3liN2ozSVpMY1dQdDJKbGJ5eVZVdU50anVRaEpN?=
 =?utf-8?B?cWVSUUtDSjdtTDNGelhOa1ZmZHM1VkJlaVY4cnExYXFRY3pRdGZ3WkFFVVNu?=
 =?utf-8?B?N1RvSkY5dFptYy81RXJSMW1wZjBELzBVQ3BFaTFKL0ZGZkhNc2FxdDJLMzd5?=
 =?utf-8?B?OXFKM0pLODAzRllZQ3RxQ3VXUUQ3citzTmI3bkpmV0pVTGtiYnA5Zkl5TFdH?=
 =?utf-8?B?OVEzb2k1clR0Z0xzM3ZQTVk2TmUvRnpjdzFuY2ZZLy9uRG9HU2tLNGlRMHAy?=
 =?utf-8?B?WGxNQmVqUzVoQ0YzbTcxalBWRFhTMVkxY24xM1JRWFhXK0R0emVyY0Z0T0E5?=
 =?utf-8?B?RC9HdmN0c1g0OG04YjZMTFdTaWZzOFkxOFRHZ3piblZiT01KamE5TUZoRHE4?=
 =?utf-8?B?dE4vMnRaOFZ6U1BrNzB3SVAzc2I0cklHUHZESXZweWpUS0tIMkZYYWhZRENx?=
 =?utf-8?B?dmE0L2ZLOWFSbzVTOFNmWFpEK3kwMmE5QWJ6cmFsM3lzS2pmdXVTVFdTL0Nz?=
 =?utf-8?B?UjJVMkFwejROY0swekU3N3FHTlR5eUllMDZHSHVIYm5GektRNmdpQW1laUl2?=
 =?utf-8?B?dFpoWkJBd09PL01QSklNZDB2Ulp4Sjk1K3lseldiL0REai9hakhpRU5NZXlQ?=
 =?utf-8?B?WDVrWk1Ia2pVL25GUHk2RzVKandEV05Za083eTU2T0V4R3dtR2EvK0twZzc2?=
 =?utf-8?B?S2daL3FhNk50b1hRVzN4SkJNSXdSOHhkYnZXVEF4NlJBNERhYkJXNkpQUGta?=
 =?utf-8?Q?yH62Xjp3HaBAY2kY5wzkszQYU?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c287e74d-910c-4878-8f13-08db6b0bd6ee
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 06:11:20.0351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gIQUUyWL2N5txoivdWQWJ3y1LRmfVEf1fZQ2H1URUg4oRPjD1NlbWQ4dPJ9lnZPATPJrVxty9moYPVeSZkJRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3481
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Jun 2023 06:11:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11969

On 12.06.23 03:30, Su, Bao Cheng (DI FA CTR IPC CN PRC4) wrote:
> On Sat, 2023-06-10 at 11:55 +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Brings one new dependency: MIPI SyS-T, a tracing infrastructure.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  ...02211.bb => edk2-standalonemm-rpmb_202305.bb} | 16 +++++++++++---
>> --
>>  1 file changed, 11 insertions(+), 5 deletions(-)
>>  rename recipes-bsp/edk2/{edk2-standalonemm-rpmb_202211.bb => edk2-
>> standalonemm-rpmb_202305.bb} (69%)
>>
>> diff --git a/recipes-bsp/edk2/edk2-standalonemm-rpmb_202211.bb
>> b/recipes-bsp/edk2/edk2-standalonemm-rpmb_202305.bb
>> similarity index 69%
>> rename from recipes-bsp/edk2/edk2-standalonemm-rpmb_202211.bb
>> rename to recipes-bsp/edk2/edk2-standalonemm-rpmb_202305.bb
>> index 40d979d9..1a589184 100644
>> --- a/recipes-bsp/edk2/edk2-standalonemm-rpmb_202211.bb
>> +++ b/recipes-bsp/edk2/edk2-standalonemm-rpmb_202305.bb
>> @@ -19,21 +19,24 @@ SRC_URI = " \
>>
>> https://github.com/tianocore/edk2/archive/refs/tags/edk2-stable${PV}.tar.gz;subdir=${S}
>>  \
>>
>> https://github.com/tianocore/edk2-platforms/archive/${SRCREV-edk2-platforms}.tar.gz;name=edk2-platforms;subdir=${S}
>>  \
>>
>> https://github.com/google/brotli/archive/${SRCREV-brotli}.tar.gz;name=brotli;subdir=${S}
>>  \
>> +
>> https://github.com/MIPI-Alliance/public-mipi-sys-t/archive/${SRCREV-mipisyst}.tar.gz;name=mipisyst;subdir=${S}
>>  \
>>
>> https://github.com/openssl/openssl/archive/refs/tags/${PV-openssl}.tar.gz;name=openssl;subdir=${S}
>>  \
>>      file://rules \
>>      "
>> -SRC_URI[sha256sum] =
>> "b7276c0496bf4983265bf3f9886b563af1ae6e93aade91f4634ead2b1338d1b4"
>> -SRC_URI[edk2-platforms.sha256sum] =
>> "b0f5b6d832e4dcc1d47a98ae0560e0b955433e32e8ac6d12c946c66d5fa6f51a"
>> +SRC_URI[sha256sum] =
>> "5f6c18cf1068089d669fbe81dab2325f8bf7b1298b192c276490b65e2edbbd94"
>> +SRC_URI[edk2-platforms.sha256sum] =
>> "31257160ac51a4a5f63db92d26482d6a005286ed040dafe89d01f0ee906b111e"
>>  SRC_URI[brotli.sha256sum] =
>> "6d6cacce05086b7debe75127415ff9c3661849f564fe2f5f3b0383d48aa4ed77"
>> -SRC_URI[openssl.sha256sum] =
>> "6b2d2440ced8c802aaa61475919f0870ec556694c466ebea460e35ea2b14839e"
>> +SRC_URI[mipisyst.sha256sum] =
>> "9fda3b9a78343ab2be6f06ce6396536e7e065abac29b47c8eb2e42cbb4c4f00b"
>> +SRC_URI[openssl.sha256sum] =
>> "b1270f044e36452e15d1f2e18b702691a240b0445080282f2c7daaea8704ec5e"
>>
>>  # according to edk2 submodules
>>  SRCREV-brotli = "f4153a09f87cbb9c826d8fc12c74642bb2d879ea"
>> +SRCREV-mipisyst = "370b5944c046bab043dd8b133727b2135af7747a"
>>
>>  # revision closest to edk2 release
>> -SRCREV-edk2-platforms = "4ad557e494d8055f5ea16009d6e565cace6571d6"
>> +SRCREV-edk2-platforms = "b71f2bda9e4fc183068eef5d1d90a631181a2506"
>>
>> -PV-openssl = "OpenSSL_1_1_1n"
>> +PV-openssl = "OpenSSL_1_1_1t"
>>
> 
> Any clues on when they will upgrade to openssl 3?

No idea, better ask their community. So far, 1.1.1 is still maintained
at least.

Jan

> 
>>
>>  DEBIAN_BUILD_DEPENDS = "bash, python3:native, dh-python, uuid-
>> dev:native"
>>
>> @@ -49,6 +52,9 @@ do_prepare_build() {
>>      rm -rf
>> ${S}/edk2/MdeModulePkg/Library/BrotliCustomDecompressLib/brotli
>>      ln -s ../../../../brotli-${SRCREV-brotli}
>> ${S}/edk2/MdeModulePkg/Library/BrotliCustomDecompressLib/brotli
>>
>> +    rm -rf ${S}/edk2/MdePkg/Library/MipiSysTLib/mipisyst
>> +    ln -s ../../../../public-mipi-sys-t-${SRCREV-mipisyst}
>> ${S}/edk2/MdePkg/Library/MipiSysTLib/mipisyst
>> +
>>      rm -rf ${S}/edk2/CryptoPkg/Library/OpensslLib/openssl
>>      ln -s ../../../../openssl-${PV-openssl}
>> ${S}/edk2/CryptoPkg/Library/OpensslLib/openssl
>>
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux


