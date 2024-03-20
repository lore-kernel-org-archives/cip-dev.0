Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E68AC6FD1F
	for <webhook@archiver.kernel.org>; Wed, 20 Mar 2024 13:41:12 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.79])
 by mx.groups.io with SMTP id smtpd.web11.45002.1710942066592230018
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Mar 2024 06:41:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TVbZBZIv;
 spf=pass (domain: siemens.com, ip: 40.107.15.79, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiq8rTgqmp6Hk4irn9TjEXVHzvGksuXGwHSgobPk2GvtVT3yfkb7x3rH3k/X0K/u+LOlpGVivn7f7a+W6pJr0eXadTRT+D90V9VRbm+2a2/8edMlnVgPtnOmhc0SGDQ1j19XHgKpUt7RrkpzTC41bIfGERsEuB4VPgkXC0rEttN03RW0jcbtevWdMSVFhBfl2umWZR35NbSRNkagBHVtDTvJZimZwgl5qBaI8xLkJJQwxGm8sGjDJqNWCGrGPgCgc6xgsUagUKDNfD0CEBgveO9UqGQtsdMWRKBSTTWXO4bOXgjU4nCbJE6QQDpkcZljH5wjUEq3leiybKXSuXJKjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66d5KyK1d3HBvKpN/03OqfQsBVgCBoe6AlBhrUo6Qmk=;
 b=frVsT+86mojKJ2iSsA7l2bapdphovEiThFJqIP1G0LC8yOZutoDgr5B46ldDH+sx9/DUaaRqxoveQ+ZUJdV03IPdVum8Uk3kfSuWEa2oDSVO6NWSEXWd2FKwT/qSNAaC14Hw8xp8387waoDyo0jD6yxcu2W1qR5jHWHhcscNFL/hmnvQJvz/wcsfq5JI7SQ+UTFXZLoPIWP1/payQzkYhq2yGSQVBJeHtpsDiPDm+KKrl+d7FN6FDi/LUGBHDvXu4QTP7hlfRoJnr6j8bapvck/Rgr0XFYwMJhw6RORzl39gRaCgMrnaOGFe8OCjZIR9Cvc3s+X/wv3aVkmvaO8OOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66d5KyK1d3HBvKpN/03OqfQsBVgCBoe6AlBhrUo6Qmk=;
 b=TVbZBZIv8dt2qIluhg6ZwqUmslPE+zllWWm43VDjyMhwnDTYagp6UJurqw9GI6XvK0KJy6wFyQn7BWfRrdgBl8JeP+PzUPdMutFNIxEkDRIDSAXKqe7ZaA+Rs7YHSvT5APKY9lWMO4trd/1S64HDLqb1Dbk42QA2AjFOBRx6S4w2JMrdEuE02dvBO+nHb7V7u0sqHZSB9DL40Qaj2/gD4MKkdKlGrBJ7xj4icT3AOPmqjDVTIGUfxAB7FRxCA3aoSdTa1dO9C3Bzh3eOp2L0nJCjJJsYJ+bc0ekesxibpKUV5jfub5yeEdj+kM8DToAt2GJQcz5jnHsZ1KbkhddxXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6679.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:401::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 13:41:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 13:41:03 +0000
Message-ID: <1ca9f272-7bdf-4188-9ae3-d89dfc4ca796@siemens.com>
Date: Wed, 20 Mar 2024 14:41:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate-handler-roundrobin: Add
 link for handler search path
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, Adithya.Balakumar@toshiba-tsip.com
References: <20240320130056.2335582-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240320130056.2335582-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d35b82b-b665-4f1f-8656-08dc48e362e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pbRmsZva513cgG7S8faSM9uGD2GcbWyA/WuPJ8tMZ+TAq5XZ7uaaDbgKeWm3jIE0WyTRmrFQFZ33A+Fb9jtNTtbMnmCanrz/Z5QMhnn8fKNelodt3cNAm2rr1T8IReZzf+IdI64T1IEN+/VaxIIsQDzXDSarJVWSiQXJ5x4P0RhFmDYvgkZSxznD/TboMxQPDO5xKv1EqznJujsU3Z1XS35UPbpDguVwX7QYKekANYR3Avn30mvBSZ0DBlsc3dLiDvWLurRSAZ2IDMAJryDt3BxFUpWz5Vn8pQfmsipTWAoOgl5ZXYAfeOXddbqea8KiBZFuF+oFoBa6IQjhzUIVr7cUc0pXnJLK5obzdEHtle2Bys2VKHmxs0reB/adv4P4NttuUzTKf37inzerpxarktT6tsw9bOI5j+WXYf4is2DdvAXMumIJ1Xd6iXGxnss3D3u0P1exNsyOs0/ANbopufEHiPRquGh2OkpkvjVUL3Gd3RirlX90FbA3dw+VNltJhRiHnlL4oslLSBC/umsyxvFGgMJAlzDONnh79z/JAee/F/gkkebLmETAe8ihjSfFFeP7E2eZwYreP/GDL+XxfzG82xoyIqP21KvDaAjSh08=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eGFDWnBwd2JwU01XVnFDWU5nYlNQWkYxMDJlWmN1aVFHUUNQQzEwV1NNcWYw?=
 =?utf-8?B?a2FUSkY3WS8vTENMOXhvZjNEejhjWVZIZVVxcGRINUVoRjRXZUg0czJVTGFL?=
 =?utf-8?B?UlJlNW1uWEdpaS9oMU1xb1hWN1VzN09DdEdVUktkTXAwVzFXcUpGeHI1b2Jm?=
 =?utf-8?B?MFhtSDFjQmJ0b2JEc01Eb25NL09GZk1GZnVaMmpRdnFtTXRuSE1RVjNhNHJq?=
 =?utf-8?B?VkZPRG93NEJYSlZFV2hITDhnRlloMWg4ZVVaWmpWaEcxczU2cTBHVFR5eGJV?=
 =?utf-8?B?QWRLcnE5YnV1M011alRHOFdORWdQa052QkNqWjNsejhtOXY0czBYSEZLR0lY?=
 =?utf-8?B?Unh2VWEyYnZsVXBLaThIVHlVNTJYa1NKUGZDaWw1NEV5ZW05S2dhZVh3cWFk?=
 =?utf-8?B?YzNYZnpYMzZIenhXM2VsT0RySDhVZHpwWnpXaWx1dklMVi9Ma1dDcWJsVk9Q?=
 =?utf-8?B?cEpwZUs2UWo1SEl6ZTFzM0lOSWhnSHNGenQrT2l2N2FGZDFGaW5wUTdoYkY0?=
 =?utf-8?B?OTFiSTJYTkVBcjV4QnROK24xZ3dneVlmY1RCYXN5NFVOeHk1bTZ1ZE1pSU8r?=
 =?utf-8?B?QjFUZjlMZ2NPSTNpVzJOQmJiczNEY3ZKNGdGWjJMQVBUbk9vTURsQnZ0UVBB?=
 =?utf-8?B?ZDllclQ2Tmx1UEF2YkpjOXBSWmJUaEFHbTVhY1hvOGlGMC9iWEVUYjV3bHM4?=
 =?utf-8?B?b1RUMlhsQlZQNzhESlR6bzdFSW5WeEd0V0I2cjRqSFJwS1F2NmdjLzdXUHc5?=
 =?utf-8?B?cUhkR2ZvZFR1SHdqUk8vVVNOSEZHYWJwWDFJZjA2VjdYbkh0Y1RiSko3SDUr?=
 =?utf-8?B?ZzdDV1doQlB2aTl1ZkUzZ0dTT0U0RWhERXBGaHNqUy9yYmNQRkRiK2kySWpJ?=
 =?utf-8?B?bUFDZ1dxL3dTbG5xWlhKSVJLQ0txQnlkdEQ5VFphcDhBVElYbExDNkc2RXFO?=
 =?utf-8?B?MTRvdElJM0lXSldUQ2oxeUFqVTFZRlIycHBwNldPc2lVeDdpaC9wS3oxZXBo?=
 =?utf-8?B?Z2VWMkVibzVDZXNZVDBWSUlySTEwTHY1bVlKcFAyaHpHZmhMdXljd3JaaTk0?=
 =?utf-8?B?NnVwVXdyL1lQdHROaFRCR3Q0V20wRENsNkpaOTNKOTZ2ckRtRFRFMzQvWW9v?=
 =?utf-8?B?KzI0YU8vby9xcHJsQk1ESDk5b3VFR1ROVG9zUVM2cWlZa1FGRDI5VHhkU0Vs?=
 =?utf-8?B?UXNveUJWU1FQTlVNakdIeVRXMFFTOFF4ZUxJd1pqOUV5aGhGMmd5NTM3V1Bq?=
 =?utf-8?B?QmZIdGxmTkxoc2hMcFBNc1B3eGFaWnNkT1FMbWlvWTZYNFRZQ3RMVldHQVR4?=
 =?utf-8?B?UjF2UzM2UFJ3ekVsWVpYSFJSQm84SWtQUldkTnBML1pUazl3ZjQ4Ukt2SGNJ?=
 =?utf-8?B?Q0tzRHF2WmJxM2NsckpWazhFam5tVWdmTXMzdGtuTnoxaUpOV3pxeDBrV2Ix?=
 =?utf-8?B?d3NLT2UrNVAwSEF2WE5QWldIeUloYW5pWWpqMnlyVGJxa3lxSFg1d0VZWG1o?=
 =?utf-8?B?M3NTTzh0VlNWQTdITUdIazlpOXo1Y1pyVlFtUU9LVkZrZnU4R2FzUGVvRklr?=
 =?utf-8?B?VlRDbVJNOVIzSVpQenpLa2Z3aEhBRUkzZjd3SE1LcE5OMTFYenRFUGZDbnVj?=
 =?utf-8?B?VUVzaTlyeTVENVlhTWVHejFzeTdqaVJwN2JSdzZQRGhGN245ai9nZDBsN3hi?=
 =?utf-8?B?ZzA3RGRxei9yWVBZZy9wendKMmdyb0x3QmgzanY4QUtpNStVRjdEWVRzdDJM?=
 =?utf-8?B?Mmt4MmR0K0htaUczOXRsOGlEclY2MVZaVkVLd2NDUEZPb1l4V3JuNlZkblhV?=
 =?utf-8?B?MnBFL0UrRnh5RXFXZWFvSCtNU2hjMXQ3cCtDVE5BRXMyTFJjMHlSOUdqa21q?=
 =?utf-8?B?UDFPYVpNYXQ2TjVKcFNZdTM0Z0NCL3JPZ3ZueGRwVFlBaXJ3bFMzSGtZZERy?=
 =?utf-8?B?VmJlR21MTEdkKzROOUY5ZzN5Y24rdEVaL0JCdXNtOEVNN2tNQXBkeG1zVE50?=
 =?utf-8?B?TUdPYVRlcDhMMEVsV2E4NTNwZjNKNlBhTGNmTEpINXI3MWtDUEtKYWRjSmZX?=
 =?utf-8?B?UmNERk4zTVEvdFBkd2kxdnF2UXhvWS9HK01tRVpCbDhwMmYzbDFKMDRyQkJI?=
 =?utf-8?B?cjJGeE81ZGE5SU5ldzZaOEdvcVZvMWgzRUhGSm1ZdEx0TUJPQlZJV0pQWURi?=
 =?utf-8?B?cnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d35b82b-b665-4f1f-8656-08dc48e362e9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 13:41:03.4829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P33WQETCp4eptO4397pZLaNnaO3zlVg8h9VuR2Px8dKMwSxU5DIVYCxjFdMdjpYeXCf7aTfgZJbHUwotrKZcPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6679
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Mar 2024 13:41:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15392

On 20.03.24 13:59, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> The lua version which is used to search for additional handler is
> hard coded in SWUpdate and debian salsa[1].
> 
> To support multiple distribution with different lua versions add
> the variables SWUPDATE_LUA_VERSION and SWUPDATE_ADDITIONAL_LUA_VERSIONS.
> 
> SWUPDATE_LUA_VERSION defines the main version and for all space
> seperated entries in SWUPDATE_ADDITIONAL_LUA_VERSIONS a symbolic link
> is generated.
> 
> [1]: https://salsa.debian.org/debian/swupdate/-/blob/6ccd44a8539ebb880bf0dac408d5db5de7e2de99/debian/rules#L13
> 
> This fixes issue #102 SWUpdate failed to install update on bookworm
> amd64 image.
> 
> Reported-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../swupdate-handler-roundrobin_0.1.bb           | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> index b39278e..95ceedd 100644
> --- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> +++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> @@ -20,12 +20,22 @@ SWUPDATE_LUASCRIPT = "swupdate-handler-roundrobin/swupdate_handlers_roundrobin.l
>  SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG ?= "swupdate.handler.${SWUPDATE_BOOTLOADER}.ini"
>  SRC_URI += "${@('file://' + d.getVar('SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG')) if d.getVar('SWUPDATE_BOOTLOADER') else ''}"
>  
> -# lua version 5.2 is currently hard coded in swupdate @ debian salsa
> +# The lua version used by swupdate to search for additional handler is hard coded in debian/rules
> +# see https://salsa.debian.org/debian/swupdate/-/blob/6ccd44a8539ebb880bf0dac408d5db5de7e2de99/debian/rules#L13
> +SWUPDATE_LUA_VERSION ??= "5.4"
> +SWUPDATE_ADDITIONAL_LUA_VERSIONS ??= "5.3"
> +
> +do_prepare_build:append() {
> +    for lua_version in ${SWUPDATE_ADDITIONAL_LUA_VERSIONS}; do
> +        echo "usr/share/lua/${SWUPDATE_LUA_VERSION} usr/share/lua/$lua_version" >> ${WORKDIR}/${PN}-${PV}/debian/${PN}.links
> +    done
> +}
> +
>  do_install[cleandirs] = "${D}/etc \
> -                         ${D}/usr/share/lua/5.3"
> +                         ${D}/usr/share/lua/${SWUPDATE_LUA_VERSION}"
>  do_install() {
>      if [ -e ${WORKDIR}/${SWUPDATE_LUASCRIPT} ]; then
> -        install -m 0644 ${WORKDIR}/${SWUPDATE_LUASCRIPT} ${D}/usr/share/lua/5.3/swupdate_handlers.lua
> +        install -m 0644 ${WORKDIR}/${SWUPDATE_LUASCRIPT} ${D}/usr/share/lua/${SWUPDATE_LUA_VERSION}/swupdate_handlers.lua
>      fi
>      if [ -e ${WORKDIR}/${SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG} ]; then
>         install -m 0644 ${WORKDIR}/${SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG} ${D}/etc/swupdate.handler.ini

Thanks, squeezed into current next.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


