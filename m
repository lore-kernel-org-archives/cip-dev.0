Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DB6E92FE4
	for <webhook@archiver.kernel.org>; Sat,  7 Oct 2023 05:42:15 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.57])
 by mx.groups.io with SMTP id smtpd.web10.13079.1696657324133630384
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Oct 2023 22:42:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=jqSFZYRU;
 spf=pass (domain: siemens.com, ip: 40.107.20.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ht4D8H3N9mN/WXqRDC6abFGVagiDCJ+LbhXLowi7iLwyFq3z+NVGFjw6aOkzvLCKEXxzmMaC0QVBgnatN2jA0F5nTPxXCnovsJLoVOjy2cAXWjE6TBYWrp1ZL2gKxQaOQC81sjifUidisNPnPGUmNLTUqsHZtaD2ZDQMHhXPmGXG7HdcK3gLmdWNqw0xy2dUf5AnBJ/e32yka3u5IFPScRLhiF/HrBMunOp5fVCFFdV+AyeanDjfvdSQDv8Ht5FytYd76b8fMSlZk/myElO9hbI955rL/d7D5A4mwgVUUGf6Fe5B9a5gptr2TzDAaEh8yhr23U8BRxs8K2m6SJVnIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3RvqC1wF3xsgkuD1FBEwW6/AnDSSGxjP1pVv6h+yXQ=;
 b=DUj+v2ZxRRbkWSAcL6bN0zWeF5cqQFMfvVArpRzBWHJTxkcajvEc5gH1Rkdogt8DNe4uY5I3rZLfZMhwUXasQ0enfJCUu0vCpH3LlX0Hf257+ud4eRCO+nHkp+MwK2YYo5iiqyn5GpkUOTD7N5+D86KzRxVhDLEmf0LzZGWBFWkRlDRA4mgzNPlYW+FoVSBN8PWaeWPywJ7VFZmJdiUiztPaWA8rWRpjYcmZeqYRqStyJO8TUlfrXRMxtzzuD9R6E7DcRrbDrRbXzzpIJ2yrkTY45Qd9Y7s34QT9N1ucbJIzrjEodGV2AzzUzV2JxZLZxw2IhTjOO84W0P4MShma/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3RvqC1wF3xsgkuD1FBEwW6/AnDSSGxjP1pVv6h+yXQ=;
 b=jqSFZYRUaUEmoauPg3nHqyZzA065ypuvtDc420Cap6dlkFfF0y3noGoyn++BReGxI8qET4OqYUkPSShsFbYrvz8gZN79tAknKns3aQcy3whOt/9nD5AgqC/FYGr/vcPDa4yRN5lhan1KUWQPmUgpqLHWmwzkFRG/RMZJu6EWOcFM/t7eRcyPvNwei1TzvlXfRZEAWmXsoJ++IBko9SPfdavHiZ7YfVRjun5zj8j5OGuYRBc/F9aprcmqA89oSO5vfh1fHPVTcca/EqusJWZahhmZoC+70F296hZxSZM0a3VnBC4DzwshoWhzP1flrgf6GWws8+C9H1tg0NG9boXlew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3606.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:131::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Sat, 7 Oct
 2023 05:42:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.033; Sat, 7 Oct 2023
 05:42:01 +0000
Message-ID: <82d3d3d0-fbec-4b0f-a449-460c658965eb@siemens.com>
Date: Sat, 7 Oct 2023 07:41:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/1] make method to find /var mount
 configurable
Content-Language: en-US
To: "MOESSBAUER, Felix (T CED INW-CN)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Gylstorff, Quirin (T CED SES-DE)" <quirin.gylstorff@siemens.com>,
 "Hombourger, Cedric (DI SW CAS ES LI)" <cedric.hombourger@siemens.com>
References: <20230919034336.2545650-1-felix.moessbauer@siemens.com>
 <41dc3c159b4d72cc2a099de4ae5996b518e5e91d.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <41dc3c159b4d72cc2a099de4ae5996b518e5e91d.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3606:EE_
X-MS-Office365-Filtering-Correlation-Id: fb5595eb-163a-4c9c-324c-08dbc6f82120
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cvMSoPF+Jo5zwXOvhdKQkxOZlGlAniyNm+NHq2/0KPE2mC3WBMSQ+46UbwGxUwiBMrAnF3ZX5ySsi1H9lLzJZQdvz2mfF0RXHyAgLunjnscj4P0gdQypAXp3ctD8MTn3FQUjGvTqmMvR8GR66arReeKDgXNqdvh3iHPeliHsH8JubkI+BCzSSn6ucB8AQ4zq4e6WufLy7Vq5gC4trnSfvQypKQGKe2LX5VwBuN5E3twkjft8ODp7UAwWxAKor+y2/1TuWfIBNj45+n50SKRZg/aKovmr+IDfVFtRpeikUnYtzDdlY9P4kJoV3RyEhbCQKJswLzc4kJgjYxg9HFYk9NT3r5qoIOeHBwzVzjbzF0YzDsJsctdK4wuOOeIp7Ae5V9IrLGvvHmosVETP8rsg6shUBCHm35Zu4sPM/M/rqk2/yof7So5BQru1JXjHOlgV2HELH1mGcfsLXumGYbZnsJtxqGQ80eF7S8cUwVGY/yIfBtiHKyT9X/VwM15D3aGQJ+8jJb/CMmL1HFSfI+nNRUhwtgr34MBxddCWfh5+ilVPIBGV9WVn21ByKzUWmaf5sK5Fi+h2vv9X1FU8DcpkWj/COHk0Fzn/8uqy4sA/jAwcdrDjjUXMCk7Ot2CSN2K+eMtEsKGpIOml6JFmys9+qFcyUNUp0FRSUE3qCY9r2Mc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(376002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(107886003)(6486002)(478600001)(6512007)(53546011)(6506007)(26005)(2616005)(316002)(83380400001)(66556008)(66476007)(5660300002)(8936002)(110136005)(41300700001)(66946007)(54906003)(8676002)(44832011)(4326008)(36756003)(2906002)(6666004)(38100700002)(31696002)(82960400001)(86362001)(31686004)(37363002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NEUxWGtjMyswODhIamNrcVg0SDVUSm1FTU8zSitWUHlkWjdGME9DOVFRemd6?=
 =?utf-8?B?bmVRTjVUbTM3bmlpc2d0M0YxeG5wVmhxZExnSGFEZkdLNW5GMTA0dDNTZlRS?=
 =?utf-8?B?MDVyWFVmREdSK0JrVlZRV3VOejJReTFQV3AyMzZSaVMrczZCcWlWRlBOSkpU?=
 =?utf-8?B?Yi9DN3YxQ1JIc21Dd2FaRU5ybUxxQVRXV2xkMGM1eHYwTkQvRzE2WmNqUVMy?=
 =?utf-8?B?M0YvRWc1NXVSOU9oQ1pZV2txd3IzR04rNW40MHlxcHRPUVN3ZlFlOUF2RDk0?=
 =?utf-8?B?Zkw4b0ZYQ1FQTTZ0RklSVFVoaE14Zm9aMWZMTFVyc2U4UTVDVFQ2a05yaEVF?=
 =?utf-8?B?YS9mdWEvY2xOelRWWklYbkQrSkJLZVI0TlpRd2J1WGdjRnBWSEFWQmdtdlNv?=
 =?utf-8?B?UGlhL1ZJb3RiVU5YME56SitKaHhBNE5ENmJ3a2FVYnNwaExRUlJablZWWkhH?=
 =?utf-8?B?U3pna0JKZkl3TDk0engwVzVwWjdPM0UwZzRJSmNBVFR4eHhYbFAyaCtTZHhL?=
 =?utf-8?B?a3gwNUdTUFBVR3VHa1BCMzVGS2djaTY2QVoxNGpWZ1lZSzRvTGs0YmtjZldk?=
 =?utf-8?B?UlVVaGhocm82VnNNY1FuemtRZXd5SVN0c3Y5Q0tOZExDQVhtQTRzeUEyUXVW?=
 =?utf-8?B?dnprdEhVMmZPVC9mcXZCMVVEQi9IRkNGQmJjanZ5THlHQjJmYnRjdzdIT1BK?=
 =?utf-8?B?R0Jka0RqM1hVNW0yTGxSVnBGWlE3djJ0d05aQ3Bscko5SjRYUXJIZjJrTEp2?=
 =?utf-8?B?eE1IZS9KQ2tkTm5mcVRIQ0J2Um8wN1JVNVZMckZRVEpUeFlFek5kQXdSMnla?=
 =?utf-8?B?VDh5NkZ5azdsUWRnaS9nS09EUHJKMFpPbEdtSzlXdUZJeFA4RmlMdEMvNmV2?=
 =?utf-8?B?T1BsdEtyN3Q3ZVZIRXUydE1XUWxpUmhSZXRKQkdITXBrTHJaS2NCelRzSmJ4?=
 =?utf-8?B?bmxtaktES1Z0RWJDb2pzUndtblZIYTh2d1F3UXNrZG9ybm8yMC9GTU4ybTRS?=
 =?utf-8?B?S0hWMy94YkpsUWVwWVRpNkhWVk5LUUp6OE1jSFA5bWRVVTlmVzNXMWIxZU1k?=
 =?utf-8?B?R0U2MjRKYnFyLzlubG5hOGRkdEgrZ2QxamZtRUU1VzNacFdnVFA5UUZOVGRh?=
 =?utf-8?B?NFkxbGt3aWtSaW54L2dhTmtxaDRVTzljOEJQeXNQaWM2NUNvVUZBMVdKQ2dr?=
 =?utf-8?B?ZWJYVkZMdjVHQjlZOXhCRWZnNWVGbTNxTXR3VDE2M0JkRU1kUFNWbzVHYXRl?=
 =?utf-8?B?Um81YVNKL3RrczRuQzlHay8zM0JtVzZocEFjekZuRW5tNHJ2c2cveWJsMStS?=
 =?utf-8?B?ZnQ0bjUxTHRnNlB1YkxzbWd3ZXF6QVFOakkza1paVkUvOFUyb20yVW5UaVB2?=
 =?utf-8?B?M3BkbVlpMGlQeHZ6R1NwMnhnT3o1MGxYam1lNzFpWXhhc1p3N3FqektEaW5Q?=
 =?utf-8?B?d1Z0amlqTXYvMTQ3NEtYOTBXbUdIWTVpV2wrNS90TFZVcmlpTXRTbG5yUSt5?=
 =?utf-8?B?SFBzenNuNjlTamlXenQwV2p0QlhEbERXMi9UMElpa29weGIyWjU4TnUzaW5Y?=
 =?utf-8?B?aHh3V2k5dURrM2dNbHp4ZmpPWExQeTFST1VHOWhXZEZ3TFE5YnVuLy9UMVIv?=
 =?utf-8?B?WHdUZHR6TFQwZTBJeVBKem0wbU1KU3dKa0NBTE5NTGhDK3lVM0JTRkZBY2Zv?=
 =?utf-8?B?a3N1Z2pubEpzUmNLbmRHR21aS3VhUjdpTXQzOGJzZUN2SVJtMDU2ZURJeVpw?=
 =?utf-8?B?YmFvenBza2wyVS9OQ1hWSHhvdFNxLzFkQWhHU2dIRUJNcGZjcnZuVllDVTJV?=
 =?utf-8?B?dFY5MzNzeGJza29semI0YTFGRUQ1WDJ2c0FXcFVLa3B4MEEvc0wwSVVjYk55?=
 =?utf-8?B?SVpEZk5RQisrOUowcXJ4ZjIrYUJSRGxrTjQweE81bWh5NHd4QU53c3Nzb2JD?=
 =?utf-8?B?cEZEbGM3VnNnVzRqdzhSSnBtb3M3OTRyWVJaWmgxb0trYVBtckwxL2swNFJp?=
 =?utf-8?B?a1BUYzc0Nkl4RW9ZMFoxaVo1dUk0Tzl1SjkvcVVHelZCYjgrNEJTODBqbkNi?=
 =?utf-8?B?UFNRblFGZnY5RW1abTFZbld2K1dpKzR5eG1uLzZmM3o4WVV2U29HbUpFOUU1?=
 =?utf-8?B?N3JieDZxTUVFY3dqSHNEWklWcFRSbVpPVDBrV3JZMTQzLzB3dVZMQldQaHJ3?=
 =?utf-8?B?Y0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5595eb-163a-4c9c-324c-08dbc6f82120
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 05:42:01.3943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TAdcTfxUf9G+S60qnm5oukEiYWcJOMAMudu62KqW0eHxoEN9IsZj3H0aZYilsLPgYvbex/F5kNaANC7gq/TSBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3606
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 07 Oct 2023 05:42:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13300

On 07.10.23 07:37, MOESSBAUER, Felix (T CED INW-CN) wrote:
> Any news on this?
> 

Never reached my inbox, therefore missed. But I also received no other
reactions/reviews.

And as you are writing that there are more cases: Don't they need
similar adjustments?

Jan

> Felix
> 
> On Tue, 2023-09-19 at 03:43 +0000, Felix Moessbauer wrote:
>> Previously, the /var mount is only located by the partition label.
>> This
>> is problematic, as collisions on this label might happen when working
>> with multiple disks. This patch makes the method to find the /var
>> partition configurable. By that, downstream implementations can use
>> UUID
>> or PARTUUID based mounting.
>>
>> For backwards compatibility we keep the current label-based mounting
>> as
>> default.
>>
>> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>> ---
>> While debugging this, I found many more locations where mounts happen
>> based on the disk label but not the UUID. All that should be changed
>> to
>> UUID or PARTUUID based mounting in the future. However, we do not
>> have
>> stable UUIDs for a long time in cip-core, so all that must be
>> implemented in a backwards compatible manner. Otherwise the swupdate
>> paths breaks.
>>
>> In addition, all the UUIDs should be provided by the user and not via
>> a
>> default in cip-core. Otherwise collisions are likely to happen in the
>> field.
>>
>> Note on testing: This patch has been tested in a MTDA setup, where
>> another swupdate image (of a different product) has been attached via
>> an
>> sdwire interface. As the sdwire interfaces automatically connects the
>> storage to the host after reboot, the wrong /var got mounted before
>> having this patch.
>>
>> Best regards,
>> Felix Moessbauer
>> Siemens AG
>>
>>  .../initramfs-overlay-hook/files/overlay.script.tmpl | 12 ++++++----
>> --
>>  .../initramfs-overlay-hook_0.1.bb                    |  5 +++--
>>  2 files changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/recipes-initramfs/initramfs-overlay-
>> hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-
>> hook/files/overlay.script.tmpl
>> index 71d2599..d7da6fb 100644
>> --- a/recipes-initramfs/initramfs-overlay-
>> hook/files/overlay.script.tmpl
>> +++ b/recipes-initramfs/initramfs-overlay-
>> hook/files/overlay.script.tmpl
>> @@ -27,17 +27,17 @@ esac
>>  . /scripts/functions
>>
>>
>> -ovl_partition_label="${INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL}"
>> +ovl_partition_device="${INITRAMFS_OVERLAY_STORAGE_DEVICE}"
>>  ovl_storage_path="${INITRAMFS_OVERLAY_STORAGE_PATH}"
>>  ovl_lower_dirs="${INITRAMFS_OVERLAY_PATHS}"
>>
>>  root_mount_storage=${rootmnt}${ovl_storage_path}
>>
>> -if ! mountpoint -q "${rootmnt}/${ovl_partition_label}"; then
>> -       if ! mount -t $(get_fstype /dev/disk/by-
>> label/${ovl_partition_label}) \
>> -                /dev/disk/by-label/${ovl_partition_label} \
>> -                ${rootmnt}/${ovl_partition_label}; then
>> -               panic "Can't mount /${ovl_partition_label} partition
>> - overlay will not work!"
>> +if ! mountpoint -q "${rootmnt}/var"; then
>> +       if ! mount -t $(get_fstype ${ovl_partition_device}) \
>> +                ${ovl_partition_device} \
>> +                ${rootmnt}/var; then
>> +               panic "Can't mount /var partition - overlay will not
>> work!"
>>         fi
>>  fi
>>
>> diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-
>> overlay-hook_0.1.bb b/recipes-initramfs/initramfs-overlay-
>> hook/initramfs-overlay-hook_0.1.bb
>> index 566bd15..9e78dc8 100644
>> --- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-
>> hook_0.1.bb
>> +++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-
>> hook_0.1.bb
>> @@ -19,12 +19,13 @@ SRC_URI += " \
>>
>>  INITRAMFS_OVERLAY_PATHS ??= "/etc"
>>  INITRAMFS_OVERLAY_STORAGE_PATH ??= "/var/local"
>> -INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL ??= "var"
>> +# override this to switch to UUID or PARTUUID based mounts
>> +INITRAMFS_OVERLAY_STORAGE_DEVICE ??= "/dev/disk/by-label/var"
>>
>>  TEMPLATE_FILES = "overlay.script.tmpl"
>>  TEMPLATE_VARS += " INITRAMFS_OVERLAY_STORAGE_PATH \
>>      INITRAMFS_OVERLAY_PATHS \
>> -    INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL"
>> +    INITRAMFS_OVERLAY_STORAGE_DEVICE"
>>
>>  DEBIAN_DEPENDS = "initramfs-tools, awk, coreutils, util-linux"
>>
> 

-- 
Siemens AG, Technology
Linux Expert Center


