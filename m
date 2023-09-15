Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DBCEE6425
	for <webhook@archiver.kernel.org>; Fri, 15 Sep 2023 07:07:00 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.43])
 by mx.groups.io with SMTP id smtpd.web10.15541.1694761619198570193
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 Sep 2023 00:06:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=clDbkT9h;
 spf=pass (domain: siemens.com, ip: 40.107.7.43, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kb3eZHzPFLKGZXcfASBVoom0AnOyiufdHa5aRgZWFAWQ9wiC5bLrPEeekQ5EErZpBLcRszlxyy0UJWqR7jBrmvG2vPpOWlMS8aQPasshw9JSzbMbN0zeMThGXtshit4AohgwAOJTe+cpp/uEgBjKaFo8QxGnznxyQrdrMhGoBRF68l7Z1oeBU0H1NuozsnmDvMdiCkB4xU+iXzL3Wx8c5GOnZ81NgxOhzLkxyoeIq9BgCAgtYfEHiSXE0YxoEWCMqiUcNBYVckvk0RypW1tfr/c5YT1PHH/Aytpanm6BIJX1nRUxEd2/kxoCsJuGdTeeaapLhfOdcnDUTFF2Tdsqag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyN6QWIRnmeHPIsujooz3fpbjplJsuvF4NynDQS8VRA=;
 b=dx2OoI2W8ZnZhjKvrCa2DGhS809T5NunX+GuJ0AaWQGAboFIBYl5ntPU2FMPYbc2aLK6xpWNs95u7QkdKnA3V9pLKgwzdXPmTUbTm7KIhd/D3IGb9r0HpUIAdTQW5TWfaLET3RxnRprAkWyV0Ur+93QfL2pCBmA4GWdGcq/0X5ZZESlfjioeBKbtxN6vV81MxrGFr5pO4iaTuDZZc/oFlaEJmAq6Qv0NaqARNc40BG8t6LdNfo8qGmaIzQjigHFT13v4i38vQSEFh7t5NA55G7wM9QOXBsbyx7f72k+gesQgJrjt7Fh96fK5txIozZtdndeGstuGXau6c8zXu25sXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyN6QWIRnmeHPIsujooz3fpbjplJsuvF4NynDQS8VRA=;
 b=clDbkT9hzm31ca2Aus3CRbbJz9E6p6sQ5Igf5mQxa1pAVlAASWHAXcIFM8IeBXT7ifjLke6hEtjDF2BBEOTg2IpvbnzEmKtUNusOtTz0kQwAdoJeKhZDItTYC7K3bzbW4HcGjK5XRJyeuLRt0u6YhAujW7NN06YucHG8N+i6b2ArXhKtFepZC2iT37JyeKUqu4USQGoL9N46F+xwuOKCY2b4OZO/3S/46zVzarigpyfV+fY8S9BVkBa8h5tmQdiYO71FgY2NbndNFNR0XYi6jQl2qMczZwyYAgOEgVHdJSgzqfhu3btXWvYIvTJotPVf2URMbibCQD/0IStkBNo4Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS8PR10MB6995.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Fri, 15 Sep
 2023 07:06:55 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a940:1b51:4279:2219]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a940:1b51:4279:2219%6]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 07:06:55 +0000
Message-ID: <417da0c3-db9c-fd6b-97f0-563da2320e05@siemens.com>
Date: Fri, 15 Sep 2023 09:06:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [cip-dev][isar-cip-core][RFC 1/1] classes/verity: Set salt and
 uuid for reproducible builds
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 felix.moessbauer@siemens.com, adriaan.schmidt@siemens.com
References: <20230914185102.1451907-1-Quirin.Gylstorff@siemens.com>
 <7fce798e-8ac1-40f4-83c6-4fc4ccb9b304@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <7fce798e-8ac1-40f4-83c6-4fc4ccb9b304@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0222.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:88::15) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS8PR10MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: b43a35b0-2942-4f33-754d-08dbb5ba583a
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+InBkQQs412qWdBDjS4BqFi/jtmruAkOXHHvCkjSre0VvG2YCd8Q0AW00lfVFaOmJsUakEiNhH2vjzGEP70TiYcX5uYFQx1LV5+75+3lDDkCEn775hAJN6g7NK+NFvBNCEsepP2IeAZ9Z4Ypj7iyItVJ5HA4X7+0xpYboB7jg4SdGuglJLkX3ICGVc+LY72WyQCeq7pMMaowWpHzfTL8+fsUtav+sINBJXt/uIymGLefl1Bcuc4Jg8hHdb3iKiVmizuRZA1nSrzP5hw0TqSLl3VQrEx6zrk3/w8/DFxXrksSfW5X9d2ccu2ToxVZUVPQfQDwv7Tli2z9pUySViwvtS7ETc4Zvavd4768WjOkXBwwlaGsjPPXGsEf/0OeaLFXywQsRNvM3vqMDqgQ3raqTpatM4XXePpFqeOM2bLI37ByesHiDbGKYj143fn2RL5FMZS8LoTnJVm9okel8yq7wvmCztO2R7vuEZVTQNNZufTxXjl5l5ydWqvKxW3SWV0zOPtrJ+7tRkCvq6+qE/u9klryaLaeSmilPf2F4P+Kz6S+MSsT7wJqH23Y9a3xAZyJ7jCNPywzhk05eI0hgNm8e8EHJImJMo8vPLfAvOZcXChuSeBn27PijkqHqrRvcdwBCkph+if6D43yO4XkUe5Dl7fexi89sR6NdPM6XObOc3g=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(396003)(39860400002)(1800799009)(451199024)(186009)(31686004)(6512007)(53546011)(66556008)(66946007)(36756003)(5660300002)(66476007)(2906002)(8676002)(6636002)(41300700001)(6666004)(316002)(38100700002)(31696002)(966005)(6486002)(2616005)(6506007)(8936002)(82960400001)(86362001)(478600001)(26005)(83380400001)(403724002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SjNvdkNvekFTOG9VSXdlTmJPZ1Nkc08xeW9FdW5PR1YrbFZrY3BUeTU5cXhT?=
 =?utf-8?B?YThOWXdYN3hDZ0cvM1QxTDV0TWlZV0k2bXBsYk93dnVJdGhhVGhyYi9SWnBK?=
 =?utf-8?B?ZTlSdnErUFpQTUFySU4zTnZWY3A3YUxUVStIMXZRbWNrL2x0K24weU5vYi90?=
 =?utf-8?B?YWp6RkVHb2lTTytVd01NMHcrdmdsQjg1QWhneTRGZ3lPaEhwbDNMUllDTUlP?=
 =?utf-8?B?aUFIclM3dUxWdWhLM25XQzJQREQ3LzhRZ0g0N05FTy9FMzBvZHJ0ak9YLzJM?=
 =?utf-8?B?VG1NQ3RDLzRsM0xldUdLNjdiN2Y2b0xJM3lqQ0J4YXpoK3BVREJEczZyd0tp?=
 =?utf-8?B?VGNsYmlvZDVRU3k2RkVXa0dwd0NRYm1uZXFiNit1eFJKK3pKWEdSL0RjODkz?=
 =?utf-8?B?NzNvRWpYTDFTWExoRXJnUkRRWkNLR0JZMTlYdzJZbmRvZERqbkpiZm5PNDY2?=
 =?utf-8?B?YlIvTGJ0ZXNQSDc2UUJiQ1dOR00vVFlzQ2RHb2JmYXlCOXAvc3pyQ1VQTktU?=
 =?utf-8?B?Z1VVOC9VVGxUZll2SUUvQTc0SG1WZTQxNTkzcEFxcDRFdEh5OXR3L04wSGJ1?=
 =?utf-8?B?b3RlSk1ZZlRWMjQvQTBUeUtrd3VOUnN5N2pSdHp4UERCTzY5Vm1VV3A0WDB2?=
 =?utf-8?B?V3hKd2VKcmZIWW9ZZzZybzUvMDJLWlVVMmZrK2k0V090eE9rNGpMTmxweExi?=
 =?utf-8?B?ZzJla2hKanRiZTF1Skx4b29lV2liVEFSeVJYS29JQTZBUEU3MWdHSmc3bmZs?=
 =?utf-8?B?K0lLNUlBU2ppYXJxRTF0VjdnZWZsT21lUTh3cE1RZnliWWk3REdNQ01ISnB0?=
 =?utf-8?B?ai9EOFA1cEZQcWpLVkExR21tN2l2eXUwMWFtNEZ3K2dqR1labE05WHJ6dHU2?=
 =?utf-8?B?aTBTL0RtNzBMUXdTU083Y0ZtbEIyc1dCTklpa2JTa2dYSXJ1L2FNSElqTUhK?=
 =?utf-8?B?dXpUallBTE5GTXlCU1R1M3VWQUZxblc1WHl3dDBOR3RzWnRyL2Q5ZlVlRnBu?=
 =?utf-8?B?QTZUK1p3aFZqSkhpRkRBbTlXY1VqaGh1NE5CTHVlUTlSK2F1QlJsdWltSVlY?=
 =?utf-8?B?bnFMNGRmeTVmV014cEZGZWQ4TnI4eHhYUXdJMXdZdUovQmFsWXZkTWxJSm9s?=
 =?utf-8?B?MWE4VXVBMHNGT0owWWhvZmNPYzBkRXJXY0Y5WnJNSXRuSUE2MjRCeDVtN0lw?=
 =?utf-8?B?QTB6MWJLQURyL3h6R1kyRXFoQTd0TGt2NEx5aXptQnlYTmVMbVFSSjJ4ZExS?=
 =?utf-8?B?RXBIRUYvOTJFR0YvWldvUkpabnV0RmlOdzJyVVhvV3BSYVh4SmhsUExaUkYy?=
 =?utf-8?B?bkh4ZFlzYlp4R3ZRT1RBcm5tQVpLRVZkRDA1eC9qdkd4ZVBDYm5PdnpuZW5X?=
 =?utf-8?B?QkE5U01aZ2Ztc1cwd3lHVFVNdFQzYndZQjFWUUlWcUpqRisxOEwvNytVdzBT?=
 =?utf-8?B?Rktqd1Y0SVhWTnNqaWhocEs3Mlp2KzM4RzR4WHRwRmRsQmovYnYwUWh4QWZZ?=
 =?utf-8?B?TjlSMkUwL1dmV0xZMUE3RWl0ejlSOHQ2Z1hEQUdHaUFiMzJlRmhvSHJwQXJD?=
 =?utf-8?B?eHVCMVlXWG12a2hVMG5nbWlhMjAyRW5tNFRYNGppZ2ZFRUpLeFlXbGRqTW5H?=
 =?utf-8?B?UVFOTTV2RVZlZWljdVlhMFh2anVOckpjTDdOS21PdTQ3WXlMdDJMUTdES1FR?=
 =?utf-8?B?enVwdzh2OWdhSElsQmUzTTdSWTlBZkxNcEtOaG9qWlVpM2g0ZnpRN1QzeVg0?=
 =?utf-8?B?aTdQcTY4RXNNZDZnZURXSDBoenF6UlJYYjEzMER3M25XK3hOOUIzSlZGd0FZ?=
 =?utf-8?B?bUlseGdIcERCbFY1RXNLeDROREFFMEpkRkx1WWw4UjZLWFl6am9YczZtc2lG?=
 =?utf-8?B?bDV5WWZ4S2g3dys1cTZNL250Slcrb0dnbHdtWDdIeEZ6aXNZT3h4K284b2Zh?=
 =?utf-8?B?L2hyS0dZY2FMQWJyNFJtZWprWWxYVVMxVEdKR1k3R2tnN2RFQnBGZ1Vsc0tY?=
 =?utf-8?B?Ny9ieFZnWi9XaVplZkhwcWFWV20vVGdFOHRnNFBrVkkrZ3RoNlozQjdOQ3Ey?=
 =?utf-8?B?YkRYbnVUUjNETU9NTHU2S0JJY1RkUzhaSjRXNzdMaFpBQitURTNoVG1pZ2Jv?=
 =?utf-8?B?bzB1NU9UdEN6UHVNUTNsVERsQkF4QktUdnk0bHFSVlR2ZUJITnl2ZVdndzVW?=
 =?utf-8?B?Rnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b43a35b0-2942-4f33-754d-08dbb5ba583a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 07:06:55.3518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NYEjy8o07ewB472W/zDttA35uMh0zxGp4DfP/L3baARfKbaU4hfQaYK8sNMsuKSRIWX6Qkf1gQmn4ppAGaMiLTQwZlFgYViFGvA7zLBHJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6995
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Sep 2023 07:07:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13137



On 9/15/23 08:10, Jan Kiszka wrote:
> On 15.09.23 00:21, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Currently veritysetup generates a random salt and uuid for the
>> verity file system. This leads to a changed root hash which makes
>> the verity image no longer reproducible and bootable.
>>
>> This also fixes together with the option `kas/opt/reproducible.yml`
>> the issue that after a sstate build the image can no longer be
>> booted.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>> Can we set the option in `kas/opt/reproducible.yml` as default or are
>> there still issues open?
>>
>> This patch superseeds `[cip-dev][isar-cip-core][PATCH] initramfs-verity-hook:
>> Ensure sync on rebuild`[1].
>>
>> [1]: https://lore.kernel.org/all/595d5791-a08d-f08f-5dee-6f9ed5d472e0@siemens.com/T/
>>
>>
>>
>>   classes/verity.bbclass | 34 +++++++++++++++++++++++++++++++++-
>>   1 file changed, 33 insertions(+), 1 deletion(-)
>>
>> diff --git a/classes/verity.bbclass b/classes/verity.bbclass
>> index 747a7ae..2cfeb28 100644
>> --- a/classes/verity.bbclass
>> +++ b/classes/verity.bbclass
>> @@ -18,6 +18,34 @@ VERITY_OUTPUT_IMAGE ?= "${IMAGE_FULLNAME}.verity"
>>   VERITY_IMAGE_METADATA = "${VERITY_OUTPUT_IMAGE}.metadata"
>>   VERITY_HASH_BLOCK_SIZE ?= "1024"
>>   VERITY_DATA_BLOCK_SIZE ?= "1024"
>> +VERITY_IMAGE_SALT ?= ""
>> +VERITY_IMAGE_UUID ?= ""
>> +VERITY_IMAGE_SEED ?= ""
> 
> So, how do I use these three variables now?
VERITY_IMAGE_SALT can be used to set the VERITY_IMAGE_SALT to fixed 
value, e.g. sha256sum of random string. If not set the 
IMAGE_UUID(TARGET_IMAGE_UUID from ${FULL_IMAGENAME}) will be decoded as 
sha256.

VERITY_IMAGE_UUID can set to a fixed UUID. If not set it will use 
IMAGE_UUID(TARGET_IMAGE_UUID from ${FULL_IMAGENAME})

VERITY_IMAGE_SEED will be removed - it was generating to apply sha256 on
a user defined string and set the verity setup salt to this checksum.


> 
>> +# TODO split if working
> 
> What does this mean?
Comment for me no longer applicable will be removed in a v2.

> 
>> +python derive_verity_salt_and_uuid() {
>> +    import hashlib
>> +    seed = d.getVar("VERITY_IMAGE_SEED")
>> +    verity_salt = d.getVar("VERITY_IMAGE_SALT")
>> +    verity_uuid = d.getVar("VERITY_IMAGE_UUID")
>> +    target_uuid = d.getVar("TARGET_IMAGE_UUID")
>> +
>> +    if not verity_salt:
>> +        if seed:
>> +            verity_salt = hashlib.sha256(seed.encode()).hexdigest()
>> +        elif target_uuid:
>> +            verity_salt = hashlib.sha256(target_uuid.encode()).hexdigest()
>> +        else:
>> +            bb.error("TARGET_IMAGE_UUID and VERITY_IMAGE_SEED are empty. Could not derive verity_salt.")
>> +
>> +    if not verity_uuid:
>> +        if target_uuid:
>> +            verity_uuid = target_uuid
>> +        else:
>> +            bb.error("TARGET_IMAGE_UUID and VERITY_IMAGE_UUID are empty. Could not set VERITY_UUID.")
>> +
>> +    d.setVar("VERITY_IMAGE_SALT_OPTION", "--salt=" + str(verity_salt))
>> +    d.setVar("VERITY_IMAGE_UUID_OPTION", "--uuid=" + str(verity_uuid))
>> +}
>>   
>>   create_verity_env_file() {
>>   
>> @@ -49,8 +77,9 @@ python calculate_verity_data_blocks() {
>>       d.setVar("VERITY_DATA_BLOCKS", str(size // data_block_size))
>>   }
>>   
>> +do_image_verity[vardeps] += "VERITY_IMAGE_UUID VERITY_IMAGE_SALT"
> 
> Why is VERITY_IMAGE_SEED not part of this list? Likely relates to my
> question above.
>
I currently plan to remove VERITY_IMAGE_SEED as it has no benefit over 
setting the salt directly.


>>   do_image_verity[cleandirs] = "${WORKDIR}/verity"
>> -do_image_verity[prefuncs] = "calculate_verity_data_blocks"
>> +do_image_verity[prefuncs] = "calculate_verity_data_blocks derive_verity_salt_and_uuid"
>>   IMAGE_CMD:verity() {
>>       rm -f ${DEPLOY_DIR_IMAGE}/${VERITY_OUTPUT_IMAGE}
>>       rm -f ${WORKDIR}/${VERITY_IMAGE_METADATA}
>> @@ -62,6 +91,8 @@ IMAGE_CMD:verity() {
>>           --data-block-size "${VERITY_DATA_BLOCK_SIZE}"  \
>>           --data-blocks "${VERITY_DATA_BLOCKS}" \
>>           --hash-offset "${VERITY_INPUT_IMAGE_SIZE}" \
>> +        "${VERITY_IMAGE_SALT_OPTION}" \
>> +        "${VERITY_IMAGE_UUID_OPTION}" \
>>           "${PP_DEPLOY}/${VERITY_OUTPUT_IMAGE}" \
>>           "${PP_DEPLOY}/${VERITY_OUTPUT_IMAGE}" \
>>           >"${WORKDIR}/${VERITY_IMAGE_METADATA}"
>> @@ -70,3 +101,4 @@ IMAGE_CMD:verity() {
>>           >>"${WORKDIR}/${VERITY_IMAGE_METADATA}"
>>       create_verity_env_file
>>   }
>> +addtask do_image_verity after do_generate_image_uuid
> 
> Jan
> 
Quirin

