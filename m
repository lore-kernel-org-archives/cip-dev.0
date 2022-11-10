Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83476C433FE
	for <webhook@archiver.kernel.org>; Thu, 10 Nov 2022 14:09:41 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.52])
 by mx.groups.io with SMTP id smtpd.web09.7901.1668089377172162536
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Nov 2022 06:09:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NtTjjjzv;
 spf=pass (domain: siemens.com, ip: 40.107.105.52, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6mRRolmjmRWySxtWno1784h/MhUAOXKiP/3gKgVV4hUkJMy9hcbimt71dyNrEQKC7pW3pjqENnO+Tjqjy/kAho8hEekL9Mdbvo5z17JfgTUB1ESH6D+71ocyXVwfFsb+rNIFcuHUuv9GB8s+YevGkJ+BfUIoEwwU8aoAgi3l/Hw92wXnrHPIHa6KpPVGQrEQsFGYqIBD+27IP66gTvThrBnYJCSJLzSSYfAQTS0QdNgtdu/yPURfzJwdOzJedTLjNwfJOTrbbAi8ss25noLiiIcltngjyExD+9bLKJFy3hPpX30Is46PdI7MFKEyjDy9iOalJtekp/nE8EaXOBSsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/O8ZSyRf8NoQHOE5dk316RUh455TrxHYnmnNGfrffM=;
 b=IomNBSkFks4gDkd/u0VWKSNZVQE3wLwF/TvxkuGMxOwMGQfRJe1egZcM4msTNoPRAUFWUwUL84V4yRw2mZPp8NtbzVlTGatWFWCLoLodqL75bYS2IzVnTMvXixdu5XX9/TsLgKNmXUaOgNXeF7/vhltAwcslelGPzKZ1IhGjMOpxcoTxgdIWKGL4GGrNUjtbxM85NUAWDZPOTIlhqnFd8ich7wzKEU0YwhoR450P7snfaJomhPwa8pxrBw1En9vUsibL7hmfpEU1spBafGfwyW63I4ZVYshwFqnzWEVDcEYXs7XdrUvkJf3MuP/EH72rwsyLi8A05iREo8hs74sx/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/O8ZSyRf8NoQHOE5dk316RUh455TrxHYnmnNGfrffM=;
 b=NtTjjjzvmFs0bL8gt1Rkj9eYjlF47Rz3iOfITn0oYbZA013bOiPe8Aafm7l2qtNQ5QYhbVcnDiYCYKnq1Lnjifj7JAPCS/+f/rSrwrXo+doQqqIePz1d7oy/LhIeXqzmirBNWcdqrcawz7RZzm0ylHpUanQ3GnqX4Zy66k2+Q0CBKh2T/JAVHfO7MLoXVpwKEI8jHxqhP3fWpJ1+EtbNyFJcE+6bnrI2a+HqQ9qQMOY6OzVLHGHuosOsVdjh8QBGVFhdDjVvrbgM9dgsZCnLiZZW+Ks9njapnFGK5H2wmJ17f+/P3k9wqAIc5hIzoSJ14UfWhfyVO9ZlPKQ1RE5c/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a5::7)
 by AS2PR10MB7528.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:590::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Thu, 10 Nov
 2022 14:09:34 +0000
Received: from PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::943f:70f7:47f7:be5d]) by PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::943f:70f7:47f7:be5d%3]) with mapi id 15.20.5813.013; Thu, 10 Nov 2022
 14:09:34 +0000
Message-ID: <aba6133b-4b3b-4d1e-b3b7-fbafe4fbc982@siemens.com>
Date: Thu, 10 Nov 2022 15:09:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [cip-dev][isar-cip-core][RFC 4/5] image_uuid: read
 target_image_uuid
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 felix.moessbauer@siemens.com, christian.storm@siemens.com
References: <20221110124503.274124-1-Quirin.Gylstorff@siemens.com>
 <20221110124503.274124-5-Quirin.Gylstorff@siemens.com>
 <880b01d9-0544-a052-e435-30933b6f4587@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
In-Reply-To: <880b01d9-0544-a052-e435-30933b6f4587@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:610:e5::23) To PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:a5::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3PR10MB4096:EE_|AS2PR10MB7528:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c82ccfe-af55-43dc-76b7-08dac32531af
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ehxBO92UAsnyykUbtuKbjjPd+GEylZDc61oOKV2kpQVmZE+CdykTp5xJMACNZZxZiE1j2hfGdugwNQzqNzoRp7N1rxQhY1yNZbA5few7iY8JPs7HuBlm+C/Tmu3sMdC7/c8jUDE8v0/BV5Ihsl/YIxXkUt5Zs7H5nMjhprKfxO+mIhFv0lNZYGUOgxRQ/ZIH9MaK+DV1KR9Y20wEI/h5dfiqavsDq0wSfP5OQgkY+1dZGpDxQZfqu8uNX/dL6kq6qy9F/KganETwc52XzyQCNxEvq3hObHXzV9c+R0Q18yoHbFbp9mseI3peHxNLysYUqusPKnWnpIBBvuMupts6imEweBvM0hI9Ho4XNNcxqHpSBaYzaTgkbPnr2Bq9V6jic5xDUpBDG4VqlzOB9eRFTk1Cgkcz4kheVjb72+BkH5hkb+4DDOMNxuUi7xRSsK4DFDlDvYLc0DjitzKsypU4qEL6aUnubgRlm1qWLBqR1ZrAqFKYvyxGLTNTmllAH4ZJI1ro0KxGYE336DHe8UFV6zoahCYgfwqYPzkNsPoGhz0q67Ka8MxC+kYBjwNKF+t2xUme4FN+i4N2xOabdFntJE8BSwosWQDrbGA65snUripAmfaD5/C7PGwh1B06IkmN3MwIcbKmA3InxcUEh1lHNmGHk312GbgDKyd5uoXQc0s+cRJpJejrN15HkssNG+IcFhg/AqiOhKuND+MAMf+lqw045KhHilhN1mJQhwo2qzwidAaNic+yLMG/u79RqgBbrZVWh2bmJkGc7qv0EaKRxZEaHosn4zfCvTnWPt7EkNxviP4fRT7yJCpO6JOKkXpK
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(451199015)(2616005)(36756003)(31686004)(6506007)(38100700002)(82960400001)(83380400001)(2906002)(86362001)(186003)(8676002)(66556008)(6636002)(41300700001)(53546011)(31696002)(6666004)(66946007)(316002)(6512007)(5660300002)(8936002)(66476007)(36916002)(6486002)(478600001)(403724002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZDVCQkpXK0NRVkNLRURJNk9zei9VZVJNTGZ2S0tvKzQvU0RyeWxIVVVwVGZz?=
 =?utf-8?B?aHFNRGRud05QbHJKY3o5elFGK2YvYjRDUW0xZnIzaDE3THN3VmZRNFNZamRs?=
 =?utf-8?B?Sjl3UzM4bVFWR0t1emVaMnpNRXoxYVVLZDc5UmJIbEFXOVNBSUUrYUJjZHZH?=
 =?utf-8?B?ei80THM3bjJoejh0Tm52YkRoNmwwSmFhMDhZZC9rVHJ0azJBSXpXYWNsWWFp?=
 =?utf-8?B?S3JqM20xaS9NUDh2T0NUWWNDMTBsdDRpRDMwODZTSWo2b09ONEtjZnpkWVZM?=
 =?utf-8?B?T21xL1ZsNWhicm9uT0ZBMlhlU3lObC9CSmJyZlpCckNJcWgrRG1TWWV4aEdr?=
 =?utf-8?B?QlR5Nk9XZXRlTHA3NU1zcGtMdW8wT0NFYWJYeVNVOVU4KzYrejU0OWRRYVo5?=
 =?utf-8?B?ZVM4L281L3BGTjIrOTV3cjBreXhhOXJkZC81NUhyOFVBZG1KajZaT2xiMjRk?=
 =?utf-8?B?dC90WURuU0k1WUdERjcyL2h5RnNrMEN5aC9qbnMzeTNrR3ZKYmZPb2VPbXg4?=
 =?utf-8?B?SWMzQWFRcnJUOVU1MEswZlN5NWtSbmFsNEVuWTB3STFmb2p4STltbzU4QVFZ?=
 =?utf-8?B?UlRXZHM3V3FNL3hNd3BnTTIwOU52b2tTWUpNKzQ2YXJETWxUb25tOW9Fd2NH?=
 =?utf-8?B?NmNSYyttM1pLUmp1VHgwajg0MmdYYnNZbmxydTNBbzFLKzdiWHY0UThWT2x2?=
 =?utf-8?B?MTJTc0xmSlp6MW5HMHZWajB3NmFZM1QyVnRoeGpycnZmdXhiQzVlblRxVTFG?=
 =?utf-8?B?VDJDU0sxK3F3enIyNUV2VHBqeTMxVzhHaGlFcTVCMXNqem9qRHJoanYyRnNB?=
 =?utf-8?B?RVI0Y1lrbFhKdTFpTkFNREtLa2YySUNncGtOYWI0N3dWMEx4QUZXc0RDNnRY?=
 =?utf-8?B?L0VTbWdpY1FBWWJwOFlYL1dWT1AwVW12V2x3MnMyNGxYYmgrYWlEZ1pzZ1dX?=
 =?utf-8?B?SmZVVjAzVU12bERhT3hBOUNFR3FXMUoxMWV3V2Z1WWp5aDhDUVQrWDloT2o1?=
 =?utf-8?B?SkJnRDFSVzYvTXluWUJES2piYUR6SmR5ZTBseXh1QzAxVzNQUldkbXVRSkMy?=
 =?utf-8?B?SUYwSll6ZWFiZGtxNzExM21mQ3NQVXhYbEpsY2tYU2ZxQ3NGbjdPZituRjJz?=
 =?utf-8?B?OFZSdHhBR3BhVFlhVzY4MGhuZSt6dEhTSjZnQk9Za2NEZkVOdjJHRmpDRVZa?=
 =?utf-8?B?UEdOY2VqdGNrNVBTblhPRkQvRVdKaHI1R01GMG5iTDdSVk9pa0tDdHZ3bElI?=
 =?utf-8?B?MEQ0RFFrdmdmY1YwNE8rbFJjL3dGM1ZlcmxOTklFL09ycHZBOWRBWHByNEZH?=
 =?utf-8?B?MlBVUkVjTUs5V0M1VC9EeWdQaVV3MjM5Sm13Z096eXBHSnp5NXJ6OWlpcCtG?=
 =?utf-8?B?ZEVHcDhxbmRMcHlmb1BpNFdHNUV5Q0EyaTE5cnREbG0zWEVoeEJ1ZUMrZHhz?=
 =?utf-8?B?YmFNNHlKSVcwaHRkeGF2YnFaTkdlL3orTWZ5aTdTUmVpSGFLZERlSHlTNDBO?=
 =?utf-8?B?N3ZEWVQwdTBLUHB3aU9nQVFML09TWXJORWpZUTR3ZHZtdGdyUlhMU2pXbWp6?=
 =?utf-8?B?NzdiWVZ5bnovOUtoMzZ1R2N5UEdNeE5EUmR2M05lVjd6V2tqTmZqVTI5VU90?=
 =?utf-8?B?UFFnMU1STW56c3FpSENuMWFvWnFQdTkvbnY3NmFWNDJTNDlHRUJFT0FaQjFz?=
 =?utf-8?B?YWVScVU5ZjdLYW5YMVd0US9HZWVPQXdvY2gvdzBDUlk4eEJ5QUo4UFRyR0Nx?=
 =?utf-8?B?ZGNUQytWRmJ6M2FFK2xwYTh2STBLNnpqUFM2WjJjcVA2K3VndnJuMkhiaWIx?=
 =?utf-8?B?STAzNkRrOUlLOWt6WTduU0cvTUtvdk5MUXhzY25pZ0hQd3JXeGhCVUpXRnNa?=
 =?utf-8?B?UktTSWpCMG5KczNrUnFFc3ZJdXVrcmlkZm1QK3ViK3o2OU5sQnNoSU1SZWhv?=
 =?utf-8?B?OVlsRWZNT2RSeTdBdmNPYWZVcktncmllSFRIeUJEVnlSQkVSZmZPTno2Q2xs?=
 =?utf-8?B?T3pkMCs3bVR5My9kM3ZsVmEva2JlSitpTXlmOVgrb3loWm4rd1RVVjhJTDQ4?=
 =?utf-8?B?NEczNm1EQllZY2J6ZXJDVi85K0dnRTFERDAvUHM2cElrSkdaRUZLUFRJUWJn?=
 =?utf-8?B?aEZrQ1F1azE2aE8zd2FPNjBGanZFRkJ3RVVrN1Q4ei9Da3dQV1BjL1BPS0R4?=
 =?utf-8?B?ZWtSSHUraUU1S0NhNDNSZWFabExxeTJYQUlTRFZ2WXJXNklheTRGUUhFWklO?=
 =?utf-8?Q?RFO08Ynr8fGQF3Rsao83KYn0KX7POd2JHBgW1JZCF4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c82ccfe-af55-43dc-76b7-08dac32531af
X-MS-Exchange-CrossTenant-AuthSource: PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 14:09:34.3177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q2tiOwCb13c72zdwouS/eGkT4RRCIv2QPV8cdfNcq5YruTsYtwVQe8Xeh3P2S/4sv6Zjr1WzwpUC2L/hguJssrScBCKh6nwGAUWXhfIxVUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7528
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Nov 2022 14:09:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10010



On 11/10/22 14:56, Jan Kiszka wrote:
> On 10.11.22 13:45, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This writes the target_image_uuid to the Variable TARGET_IMAGE_UUID
>> which can be used to validate a update against the root file system.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   classes/image_uuid.bbclass | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/classes/image_uuid.bbclass b/classes/image_uuid.bbclass
>> index 277941b..3e2e3de 100644
>> --- a/classes/image_uuid.bbclass
>> +++ b/classes/image_uuid.bbclass
>> @@ -13,6 +13,8 @@
>>   inherit rootfs
>>   inherit image
>>   
>> +# Generate the uuid from BB_TASKHASH to ensure a new
>> +# hash on each rebuild
>>   def generate_image_uuid(d):
>>       import uuid
>>   
>> @@ -23,6 +25,23 @@ def generate_image_uuid(d):
>>   
>>   IMAGE_UUID ?= "${@generate_image_uuid(d)}"
>>   
>> +def read_target_image_uuid(d):
>> +    import os.path
>> +
>> +    deploy_dir = d.getVar("DEPLOY_DIR_IMAGE")
>> +    image_full_name = d.getVar("IMAGE_FULLNAME")
>> +    uuid_file = f"{deploy_dir}/{image_full_name}.uuid.env"
>> +    if not os.path.isfile(uuid_file):
>> +        return None
>> +
>> +    target_image_uuid = None
>> +    with open(uuid_file, "r") as f:
>> +       uuid_file_content = f.read()
>> +       target_image_uuid = uuid_file_content.split('=')[1].strip(' \t\n\r').strip('\"')
>> +    return target_image_uuid
>> +
>> +TARGET_IMAGE_UUID = "${@read_target_image_uuid(d)}"
> 
> When is this evaluated by bitbake? Only on every access, inside a task
> context? Because the file it reads from only exists after
> do_generate_image_uuid, obviously.
> 
> Jan

The variable will be evaluated on access from my testing.

I tried to set the variable during do_generate_image_uuid which let to a 
empty variable in the followup tasks.


Quirin
> 
>> +
>>   do_generate_image_uuid[vardeps] += "IMAGE_UUID"
>>   do_generate_image_uuid[depends] = "buildchroot-target:do_build"
>>   do_generate_image_uuid[dirs] = "${DEPLOY_DIR_IMAGE}"
> 

