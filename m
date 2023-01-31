Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E053C38142
	for <webhook@archiver.kernel.org>; Tue, 31 Jan 2023 07:16:32 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.45])
 by mx.groups.io with SMTP id smtpd.web10.6956.1675149390325632276
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Jan 2023 23:16:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zQnV+dxy;
 spf=pass (domain: siemens.com, ip: 40.107.22.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvwzZeOZnlLSFiyks66jbvHrF9B/4+CxKdbsuP89v2eRSl56513LuKsCNB9VYFOo1toY0zxzhOahmgSs+wpUiL3ieXtttPeqdVAdlof0OXvtPWqPC3f9CD/0ZljMPoYSM8+AOTF/rxSxeayIhvRRKSemglCUv7YixS9wflscDRWT/qt9kr/aQOrsznuK6dXFCDGPHj7UbHUEzrkl/PefgKmNqqBtOY4tyJUBvGUGMcbsprky6zyoic59nUqyU61g/Xs8U9A00SIDtGMz+nbaupoFbmd6/cQ7Kda6BY2EAEGEGrIT5S/zqFUy+EridXDNHXnRbmhjWLr5RXmnnZTH0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlxxeoEQoUq4flWqgCXBl11uomR+tV49jiNNoOc7stI=;
 b=f8J79BocrZYJdCiUzaurCWVAPislQhiFJuGeTtfor7Tjxe9wgSHvrTEwNKL7iHqvJOIXXS8Snl/wKB0XeajSCtatl4qQw/juk4lLc/Jn+BEs4XNaYR4TXLZYrK5e52aFkxDE+sTH6box3r5iqtt6UAb/62uma2UOfVqPNaEZR9SPCQJPUnP9udEL0sG4rfm4riNdNP5eCYH3t9O01G4ZCqvL8oIE0rDoI/rgnymwfREV6cGg43XNbmagU7Ft+gGVLV8uQlRBtcw2MpiIcU2vvjmOeBv+7Z7kwle3uoeGWOO4snJJTuw/2HcLinaKRqnNGHk9g7IOanl1UFQAnzyyCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlxxeoEQoUq4flWqgCXBl11uomR+tV49jiNNoOc7stI=;
 b=zQnV+dxy5cx+DdSEjkcjVrCcwJRnxFJSuupFm94jqvFWYhIJwMMEHuiyIpZkzmqtFfDJiyC3v6QuXc/Go2LlxJERv7Ac6RNHXXiqNfSN3YJlF2eeSZn1QhyzjexdAPK0v+5qbBK0vglleyQZkX9U1Od262ZIYMSFjf77gcv8urOaU6Vq4rqI2zdXfeHn9f5NGOrX5nCPe2G2TpBUC8OQAGRQtQ51g1neyx9I8cdJg16tsxvOmoYPP1/hRSh/+T2So0AuzL/fAo/xbxaLcACOQJzdyRJ/IgaqutSEdpbsPmmrLb/s4n3t8CWZ+O8s7kTX1ITHzqqjaDa6yzOom0i6hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB3PR10MB6836.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:43d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 07:16:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%8]) with mapi id 15.20.6043.030; Tue, 31 Jan 2023
 07:16:27 +0000
Message-ID: <1a63ff26-88e4-c6e9-a8d5-700b4f604b78@siemens.com>
Date: Tue, 31 Jan 2023 08:16:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: SWUpdate with unified-kernel using UUID in the kernel command
 line
Content-Language: en-US
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: kazuhiro3.hayashi@toshiba.co.jp, dinesh.kumar@toshiba-tsip.com,
 Venkata.Pyla@toshiba-tsip.com
References: <OS0PR01MB61478EAC2D405DBD1F486152C7CC9@OS0PR01MB6147.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <OS0PR01MB61478EAC2D405DBD1F486152C7CC9@OS0PR01MB6147.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB3PR10MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: bc62b18c-666a-4436-23d9-08db035b117e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	v5RFqwfAlhLQJy/bupGK+m+5pfL4bcUDYi3HyX4cSkKTOBq0GxJuk0WKjvQCDx64bvmqDz05Br/yKjFiNcu9RlSmjvnmzlpBSDOnBx3jFYbeuD1g88UoTYPhBl+Splcz9H74jfMtC6S4NUkixa/pgosc69a54rzEIobcVQUmovYQXDiah2WD+ETlE/jQZR5nQqCS/F23Nj1jOZJ9DJvj6656O28gRKrmx4WEDjUBbsu5vbrZIBUEd8e8d2yCUOYsPlpsiqR+kKPJWWuf/AJMMTlvOg+iAf7YMneBeikubpz5aY0T4DKCWlSfT+ugNJeM+cMzIPAhfXtFBi/3GzO5gVwot2jmU7K9kg87dMSxRipOeFzbBF1cCDVVHa0ZKR9z7SlSjOdWVEVX8C1hErzfo5ef1v2bKVWCcV40tp/PO0UaLknEaOVyQf3krsvMUnFoJleBtDi0dYh3yD7EUMKjOxsa7xFjLkENi/JIyIbnEYlT2PAfBGoSHYPVKIl5MKl5NlywvX6IHUY3+50nomBo5xstIO6SB6qPLd/fAa5HAVa8zSxSilrTEvBD+UOmr7cTRx/3O7m/EiiehEf/JrXgWRgRz6721j6RlGXp85UN+s5vTd6NeRXFNuhIyVN96ud+iosUrZjcuqbKe+h8lr7ORKwx+vGCkjrmi2WiweVyW24cFyXWNkdALHVJx5NUiH7dyqxpvrqHX3hjTJjwIqP67ptPOi0+QCw+2H/57S2dEdA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199018)(31686004)(2906002)(5660300002)(44832011)(86362001)(82960400001)(83380400001)(8936002)(31696002)(41300700001)(36756003)(6486002)(478600001)(26005)(6512007)(186003)(6506007)(6666004)(53546011)(2616005)(4326008)(316002)(66476007)(66946007)(8676002)(66556008)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UkhNSytWYUFOcjVCUlp4c0J1TXk3dGJ4aG9wM3JwOHEvSGFERWNJQzF6SGo5?=
 =?utf-8?B?ckpZUGhuV3dxWDVPbW8xaWNCQkhEZldHZXM5RHduSE04ODBhS0lvMWdmeWl3?=
 =?utf-8?B?NS9JTlNJc2c0SXBEQnFKNjVLbUR5cVVZeThibGc1Wkh0MXBhUm9LeUd3RHNv?=
 =?utf-8?B?Wkw0TlEray8vMEVDcmY3OXhKZDd4K21FMld6T2d5M00yVXhYRHluWkZISSsv?=
 =?utf-8?B?MEVacGVVbTBkaVU0akNXWkZOdXpTNmdNNHVrRmEyZUQ0LzBaUzEvczBBSUlv?=
 =?utf-8?B?by9qT1ZkcUJ5MFhnYWxKdzl4elFqUmJSMmVCRXUxTFRNTXJ4MlZjT2xDNzU2?=
 =?utf-8?B?WDhvdHBKNjd1VEQyaGpYakJ3aUJQWGt0K1BnbVhtQzlFejZJN0JEQ2ZrcEFX?=
 =?utf-8?B?WGc1Tklsb3REQjdZWlNTcmRiU004VHNaNlp5VjJBQmRuQlNob2RSaWtaVXNu?=
 =?utf-8?B?d1JhcW9DMmlYWm9wTFdrcjN4M0hNeTJ5N29TeklvcGoxWDYrYk1jUFpvTG12?=
 =?utf-8?B?ZVE3dkt0TnR0dXVrcUVZNkZ2T0tITEU2YkZxMUxOY25XeUhLQ1M2V1YwT05F?=
 =?utf-8?B?bExJYWovdFA2U2hycERlcGVNNGtZV1gyalJaUVNtait4aGF2Q1BvL2JsbkRw?=
 =?utf-8?B?VUYxWGxJdDlpZ3E4Y1FWTTBONDk3QVA2ckgvU2hsUUZGcld2M2hIazFLSEZQ?=
 =?utf-8?B?U2FjZ0tRVk10QytwV094NFhVS24rNFhRR3NsN0NodGFBV1VXRFdaZ0VQWW9Q?=
 =?utf-8?B?S1hyOWpPeEFhNFBjSzA2SC9VSkpXK2RDQTM0WFZNT0l1NzI1RjF2V05LcFVa?=
 =?utf-8?B?RUxaQW95ekl5ZWxaWklaK1pGRUdJLzdrLzZUSFU1VjZmNTdXWXprMTBkaHhS?=
 =?utf-8?B?RG9sRmk0RlZ0dzR1enZYbEJkbnNnLzhZcjduMHhOVm5Eanl0cDhRK1d1TXY2?=
 =?utf-8?B?bGs2VG5sK1FOaC92WkYySXBCWm1wQmFPZ3VvOWZjQTNPWCt0aDBtamRMOTZQ?=
 =?utf-8?B?eEVXVHM4MXNyQXFUbnJzVmJJeGZrbEVlVDV1RTJJUG5mbEFlME85NWsySWJC?=
 =?utf-8?B?VHhIMGs4UHNGQ2RYY25KaWx5cStxVURhamtQK1dtb1BvdnRtWis2TEpsamY4?=
 =?utf-8?B?Q2k5SlNaYUZjOGhUa0lYL0E5dlJqY0Z1Tm54c2ZGbERDSjA0UFBkMUFheTgy?=
 =?utf-8?B?SlNIeDZMRC9IS2hxd1BucUZMRENuUVR1d1pxWFhLK3pFRllrUE5Td3A1L2Fi?=
 =?utf-8?B?REcxdndNSFdwdzVmRHUvazlxdm41LzdzVUsrd0kwQUdtOXhDdkJLQzZ6cms1?=
 =?utf-8?B?REhoRGN3NWU0ZlBNRzZzMThWNGFYWEtVMDhJVXB2VWJmV3oxWWZoUWl6a1Fn?=
 =?utf-8?B?NTVZRXYzbmJKL0MwN0dnQWM3UitZY000Q1JldERKbi92L0UrTFVtbHNxcVNw?=
 =?utf-8?B?Y2IvWTV3b1BRTXBoQmx1QThxSjJ0ZEFhQ012VlJld1pNY2tEeXNSbDN1ZDdM?=
 =?utf-8?B?eHNDRkVsbWRLcG1wNjdnME1wMUtaMzNSb0o5S2NEeG5nZEVRMVVCNnJ0WDda?=
 =?utf-8?B?ckYvWGxmT2phUTMwanl4ZFBJNGEybXJBanF0aHl3RS91WSszRjRTeFBHUzRn?=
 =?utf-8?B?MHExQ3NpakZZTWVYOHd1VEJkWUFDZTJYWTIrZVFGNjk0cWp6WmRvYlNIM1l0?=
 =?utf-8?B?bjE2SDZLWjBLRmkvTVBWWVREc2ExRHpXa3ZiRS9PaTRRaGJUUUJHZlR0b3Nx?=
 =?utf-8?B?OXdvY29BZVlxcCtMVGxUKzdBbldVa0tlTGxPdzZhR3VONGRaTUZWVDhPYVQx?=
 =?utf-8?B?cmlVdzFHRlE2OXhvUEcxQXpuMWtwKzIyRHFHQm11VTFsSVMxc3l0Q1E0VlUz?=
 =?utf-8?B?YlhpYVU1QXEyYmZVV283cEFWNUJ3aTBCQkhEelFVZjVsUS9SZG15TlVWdmZh?=
 =?utf-8?B?SzRHN0ZhVkFZWDU2ZWk5am90RjEyRmUvUmxVTDV0SmJxWUNPMjR0elh1dnFy?=
 =?utf-8?B?Sy93ZDFpWFUzQ2I5QUwwbWFGSXhoSm1LOU55VGliVlBXdUhRUjhjbGJHanB5?=
 =?utf-8?B?VmFIenNnUGtKcXd1Sm94UitEYXdvR2FRZU4wc2g1QnlhdHkvckRMTnhoRW9D?=
 =?utf-8?B?N1ZoaGxrMVd4c29JTnFsRFljaDlrcjgrUHcvamJoeSswUTljZ2gyd1ZpZVdH?=
 =?utf-8?B?ZkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc62b18c-666a-4436-23d9-08db035b117e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 07:16:27.4693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkeO0KTQ1AdSR3MnngfOFCoaHLg2wmayWS3cvL0zW1WT9JpdD/oUbgzu8GcNMNfztog2pJpd+ooY6cOka0mbvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6836
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Jan 2023 07:16:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10516

On 27.01.23 08:19, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi CIP-team, 
> 
> I'm trying to use UUID in the kernel command line for selecting the boot target(rootfs) with unified-kernel image.  
> Check the below details on how UUID is used to switch the partitions and let me know what is the advantage of the initramfs script approach over UUID?
> 
> * Use filesystem UUID to specify the boot target (rootfs)

We considered using filesystem UUIDs for selecting the rootfs by the UKI
 (in the absence for dm-verity-based peering), but not all filesystems
come with this feature. Therefore, isar-cip-core implements a mechanism
that is independent of the filesystem type.

HTH,
Jan

> * UUID is generated for each filesystem and its value changes every release.
> * Each unified kernel image is always generated with root=UUID=(The UUID of corresponding filesystem) in its cmdline and .swu includes the pair of unified kernel and rootfs.
> * Install the update image using raw update type (i.e. block level).
> 
> Example:
> 
> Before update, Active partition: ROOTFS-A(mmcblk1p4):
> sudo blkid
> /dev/mmcblk1p4: LABEL="ROOTFS1" UUID="U1" TYPE="ext4" PARTLABEL="ROOTFS1" PARTUUID="PARTUUID1"
> /dev/mmcblk1p5: LABEL="ROOTFS2" UUID="U0" TYPE="ext4" PARTLABEL="ROOTFS2" PARTUUID="PARTUUID2"
> 
> While building .swu
> .swu includes...
> a partition image (for ROOTFS-X) which UUID is U2
> a unified kernel which cmdline includes root=UUID=U2
> 
> While installing the .swu for ROOTFS-B:
> Unified kernel is installed to BOOT-B(mmcblk1p2)
> The partition image is installed to ROOTFS-B(mmcblk1p5)
> 
> After update, Active partition: ROOTFS-B(mmcblk1p5):
> sudo blkid
> /dev/mmcblk1p4: LABEL="ROOTFS1" UUID="U1" TYPE="ext4" PARTLABEL="ROOTFS1" PARTUUID="PARTUUID1"
> /dev/mmcblk1p5: LABEL="ROOTFS2" UUID="U2" TYPE="ext4" PARTLABEL="ROOTFS2" PARTUUID="PARTUUID2"
> 
> Thanks & Regards
> Shivanand K
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux


