Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E894C61D97
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 10:04:06 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.88])
 by mx.groups.io with SMTP id smtpd.web10.132462.1700820236028565834
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Nov 2023 02:03:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=beIJnPn1;
 spf=pass (domain: siemens.com, ip: 40.107.105.88, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsOTdX+fPouZKfKVbGRGV+AsHYX5Ps9Z03SlW//eI3EtsuFc4IfalxaRkXe/S85Cqe5HlTwdTeiD2E0usUG2GVpNGGtAcIvUQwfRmzhcDCYzGMoZEUiiDll/XX2CPfmpFdTAQf8qGGd89za3IGmn5c+eIuABw8nBC6BBeWhI9vNOfYavv8Hd1tTtKORqOTXRDPHffXrPjquGTikXzDP1fvE7o9qA/58InZajtZVbYfeD8itgYm3r4Sas677HJ33bRxAchkcdkRxO814OyvqPe4tk+tBUtDa24xgLNb2UroxCHe7zimXJow1nNcFVHetiVXAUVbqYybMyGUE9NX/nYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqJivR3GaEZRTXjD8czpFFFOJW4T+gGzHJryQ6Zu5jg=;
 b=Aa60qUsoO+CIh3DLbOf68g/pvcOlV+76wknpzQyFuFYTHq6fOj/1fxUq+tTz+d7unYjLwYAYjeiL5bsqldS6jQNggmBRivOs2Hi66Rqth7E0sHSBoCKP/og3i1v3UVI35C62ISHCvIxxrvk3ZSign3CPemwBGb7738nRSG5HmrhfBQQ4/CHmHrJdMKYpoJmLaDdSh+hWJ+HWh15vsUIXs787+V55TTZte8K9IWQOdXRsDhExShB+ibLi9ltA29mWPeLZHdsl+AFKXbHF6z2QqhoKb6cQoJLIbyflvPLbgU9/U+ntLAYpfjgEYl12zoGo30Oapnj5mqfNdxoVUh+2AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqJivR3GaEZRTXjD8czpFFFOJW4T+gGzHJryQ6Zu5jg=;
 b=beIJnPn18FRZY4r9LKPsWNq2EdRtjZT4KNl5AW7PE91b9w2GJx8aLTp3u2vYvkZXTnaXZY0kA0Rhzrbm+F8hcWppaxZqukvd0CfpCuK+/fTSRDA0+EHh0wJE0xayBo7agq03UrohCFSk4GqO0gekfQZo2y0p5+jM98HdgWNxJkVGtC1TS1OWMf7LhkHJxReD2g1bZFy/8+wUHFvnQCvs2AqqIGHFLVqXKZeUK+bVXQF7XgHuZDzt1+PsNQa1rRNolGldmvG4BUIogxxYWPFdHg1alKuBiFhB5mxLW1PlkcGRxcM5R0HCtrM96Lxg/lK5ZAZwk6gQzJ6g7fzXa99Osw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DU0PR10MB6107.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Fri, 24 Nov
 2023 10:03:51 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::573:677e:776d:63d8]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::573:677e:776d:63d8%4]) with mapi id 15.20.7025.021; Fri, 24 Nov 2023
 10:03:51 +0000
Message-ID: <0fa61dfe-fbf5-4acd-8a6a-257f2913a262@siemens.com>
Date: Fri, 24 Nov 2023 11:03:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC] swupdate: Add symmetric encryption
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20231123102923.1405219-1-Quirin.Gylstorff@siemens.com>
 <41035499-e6eb-489c-b6fd-088928dfb6dd@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <41035499-e6eb-489c-b6fd-088928dfb6dd@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::8) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DU0PR10MB6107:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a0c4d8-fa81-4b4b-2c74-08dbecd4a8d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	imPq0IL9XM9R1w9VEjoeTBloJ1ulLNIq8Sn53qet+kqgZspylvaiyZTuqa/boxphVsa41U9JvJYK75YNBBgREBSxoSrE2cRJSDAcHyws/ahzXL2xaadF8asyJDs42ih51L/woNQOfRg+11P9h5GyU0M2NcugJyZ80Hp5YD8KkcqmAjIoMvf02Cbx3X9u6QGIgPtMNeAIwL5BiFAzvNgcbuNPKEZ9GfuASjTpy7WLalqcxIfoNATTA/wnQGv2fAFtoM2Cc4SLoX90G9PpNvB+4BZYHBYPXBWNddzQdEhki6wI9RYg1ERCDSrlKv61+I83Y3Y0TJnNHkKmJ5RIpnVeMsLCe2ZyaNwJTV2N/pfUNEOZJdu9Wgw74beRxmaj4kDUwe/+QuOiE089B+yhnxtdDaBDgSYJV5+e6S6tt11FN/cno1Ogbbau5FUO4g1ybZhY8FfD1/ZhiOCox+00vk0XzSiDsdUOeYKyMTt2jaCsvRbPX1lkKZovRUXBa+VdlJ04gsvM4fN0ztiJB2k8Cky9R67s5TLsypA2YdPw5UxBO7uYZs8g4FUYRR2LWnRdA9s4Hh6YzPwHUzxHXrWDulAZkQdUVSErGwLoWaJStMoBJKeCgh9y0Jk3FetiCNSyMg/7w5HCTEDaD9GnbxkVl1Fwcg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(38100700002)(83380400001)(82960400001)(86362001)(36756003)(31696002)(66476007)(316002)(66556008)(66946007)(41300700001)(8676002)(8936002)(5660300002)(2906002)(4744005)(31686004)(53546011)(6512007)(26005)(2616005)(6486002)(478600001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SExxS1ZRNC9oWGxURnBIWmxjeGd6c0lsb0JrbTRaTVY3cWs2UlhGcS9KWXlq?=
 =?utf-8?B?ZEEya3B0WWtXb0xwZGUxTS9WYVgvMVFsY3g5Yk9RV2hCUUZDSHNFdkM2bUlQ?=
 =?utf-8?B?TUlOaXIySkFZZHhBRVQ3RDhaUEplL2JHQXIxbUpJbFhxeFNwU01ha2p4RFFy?=
 =?utf-8?B?czJEVnQyT05lV0V4RjZPU0ZsNVlUZVhWUWgrVkh0aFJoTFN5Ujg5dHhZY2h6?=
 =?utf-8?B?aC9ISXd5Vm9aK3ZSODVrZlJMTkFXRmcwQUJTazlpaWtoa3lwNldVc3dNaWht?=
 =?utf-8?B?MXl1OE1uRVNPRjZQRHdFSmE4b2Ivck9ZVWxQbUhTWHBrMG4rQVV1VUorRnZO?=
 =?utf-8?B?bkRmeGNqS1dyVGo1S242MmNZdzgvVUYyMng1TEx0QTZ2YkxwckNJc1hFNHVu?=
 =?utf-8?B?R3kwbGFGRVYvc0cvb3hkYVBQUVcyWEpkODNvSGhWZVFEYnlPbWdtVE43ZlJQ?=
 =?utf-8?B?U1pIZmd4aTRreDZWdU14NmlYVjRzSUpRR29oNk4rTnRyQy9UcG8vd2JQWVZL?=
 =?utf-8?B?Tnh2YmZIcDAwT1Z5cHJjQU5pUFErYlFraHYyY29RZlJtY0REejBLYzJrb1N5?=
 =?utf-8?B?eUQ2UlFscG1zSCtncmx3UEFHcnVEOXRKQTM4WnA4QzZpNVFRYWFONFFyL1Jq?=
 =?utf-8?B?WWwzWno5ZzBSc2hUc1RGRzE2SmZPS0pFQnVubEthWWlZRnNHcEhMdGlITFZv?=
 =?utf-8?B?SmFtMG50cTg1NEZHZmxjTkk0QXUwOHRCbVF2U3pqeWgyUGQ3RGozUkQ2SG9a?=
 =?utf-8?B?dGo2MSs2dFZ4SElXRWlDSVcwNUFOTThyL2ZTWTI3K0ZvL1JncWExVWVtOUl1?=
 =?utf-8?B?aFZMV2ladkF4cWc0MXpMM0lXWTZlZFZQaGc3ZWJ5ZDdOajJ2dlFMM0NQa0Vl?=
 =?utf-8?B?R2docWtzVEIySXRLanZ3TmUzWU5BZzhhay9xcnJiUjMrcmRrRDVzT0VnejNI?=
 =?utf-8?B?bkx4NkFqeVRLRnVsYzVZbXFmRG96NG13M0kxS3JXUXEyQ0pTaUlKZllWN0xF?=
 =?utf-8?B?eXdRdmFPV2NXVGV3akZkK0hNODd4TFNrV0NzUzl0cnhXditzcTBValcrVkQx?=
 =?utf-8?B?dWg2OWVQWU8rc1NzVlFoRUZySGFLTFVYTjhPakVTZ3c3M1R6dW9lM3g5SzNx?=
 =?utf-8?B?WE9Yc0RQbWx2UitaalhzZmNMb2srcnltMFRReHg4WlczbVR4b2wyeGYrU1Nj?=
 =?utf-8?B?T0FBdS9LcUFNcTM4U1RTZjBEbWY5MUg0SVVMb0s5MThpVlR6YkUwWncxMzBa?=
 =?utf-8?B?ZlpmNERQQWl2WnVNSW5XUHEveUY2Nlp3YlNSdlB6TEExY28yc0xyQVUvUUFv?=
 =?utf-8?B?SHJGNnVhWUVFeURPNXlTY0l0NUErQytScE5CR21wakJhK3Vxa1RRNFdSTWZI?=
 =?utf-8?B?Qmx3VG5iRE5GSnRNa0hHV0lBbS8rSFMxcXZhUjl4WWJZV3l2bHBhMHlodml3?=
 =?utf-8?B?VTlFRDlQOUVzKzN2RU9jOUJabFNsMjYySEpUTEpSUnNTek5DUFJ4dnVPcHhy?=
 =?utf-8?B?eVFBeTljSU9LVUdpbG0zaHpGYnlBdjNsaUtad0dPUjZwUHZ2ZlBINllNUWR3?=
 =?utf-8?B?Y1F5WUFQTlF6bDE1WkR5TG1CZDRnVU5KdUR3VnIxakpCSWg5OE40ZzFrbkc3?=
 =?utf-8?B?UTZCN2RQWWtPMHNMWU9EWGgzWjFMS0k3YzF2eEpFbXZLYzQ0ZW04b25ZTnRR?=
 =?utf-8?B?ckliYTMzRlBvZ0FRY2N5U1pqWURIZFFiTDBmRXFzMnlBMkJaeXp4MmRZTUUv?=
 =?utf-8?B?UFJ2MlZ1Kyt6WFBOTG9qaWVnMXBzYWluSlJCYzJMWUFFS0JLSlE3anMzdm80?=
 =?utf-8?B?T0lTQk96TEtsWHFzZFJ6bXNVWFhZSkJnRFZETGRWaTI2TGs1bkZRSjVrT0Vk?=
 =?utf-8?B?VzlxQ1dhR3hkWkp1TWZKQ0lzK0ZYZzdBMWNUUllubmU1WkY2dzZXbThqaHhM?=
 =?utf-8?B?bWs3cGNWcjRqMG9lWjd6N2NVeDd5eVZ6dTZRVHdwR1A0aTZnMHAvMm9tVWpj?=
 =?utf-8?B?S3pENUNWYXMzYWorT3c0Y3RxVmE0KzRFeGlFOWpUakozN1EzWmRFQ0RiUWlY?=
 =?utf-8?B?Ti9PSVB5SDlJSEJ5Vit1K3pvTTNqM2dwZTlyVnl1cUZsa2NnanFEU2FnajFS?=
 =?utf-8?B?UlhLT1hiYm9aTzRMS2l4UWVqOEgzY3NBQ05GVGwxUmhSWDdCQkp0Y3JjcFBU?=
 =?utf-8?B?d0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a0c4d8-fa81-4b4b-2c74-08dbecd4a8d5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 10:03:51.4984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMFZCYhwhLcDDkc0zWS3r3aiIxvUptiqAUw+COPzlaWf3FiPdIhviZawse0iYhThkj120sRbVoQSYvpHH1MJXiKJ/hYj4moQPXJXyIaIbUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6107
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 10:04:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13716



On 11/23/23 16:35, Jan Kiszka wrote:
> On 23.11.23 18:18, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> by setting the variable `SWU_ENCRYPTED = "1"` all files will be
>> encrypted with the symmetric key SWU_ENCRYPTED_KEY and
>> SWUPDATE_ENCRYPTED_IV.
>> This key will be stored on the device to decrypt a received *.swu.
>> The default location of the key is in /etc/swupdate as it can be
>> encrypted.
> 
> But how does it get there for initial deployment, given that we do not
> pre-encrypt the image that is installed on a blank device?

Good Question, I currently have no good solution for a open device.

A way would be to use a initial public key and exchange it during first 
update.

Another would be to enforce the encryption during the factory setup.

Public key encryption does not solve this issue as the private key would 
be stored on the device.

> 
> Jan
> 

