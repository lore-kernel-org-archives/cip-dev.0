Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CED9C433FE
	for <webhook@archiver.kernel.org>; Thu, 10 Nov 2022 13:57:01 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.67])
 by mx.groups.io with SMTP id smtpd.web09.7726.1668088615521340750
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Nov 2022 05:56:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LY49PLVT;
 spf=pass (domain: siemens.com, ip: 40.107.103.67, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSG5Ov98uBdzKpFNN+kBHVrwurO2rDDMjbZDppnQVNh/v+KtrQ6NHGZOQCRmfW8mAfil1MlOS7pB7E8HTAaoU6IH6jaloT6qfAcU8fCZPiV81FZKb/xo7hw1eLwTotGoXUmx4JXG/Skp4A9+G2iZNHMfdaMsIkEUqDKi6dlWRd9M3gbUzolqRWy9H4jsNbKrjog+wEkSoxH/GXLELCiEbsYrUaE7wajlscsLJBHD6fnhuug/jQYgUGKSnXrYWhwga5AyknrDm5v2PfZc9UFu/KC1/F8feV4xAlhjH3H16GdiW2wPKFs8fim2U5DNB73gLFuIiWDYzROe+7wujlFxiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFcjThARwawNGD+N6FcdG58yueYETXA/T9C0hSxpNyU=;
 b=J+t55orEqrUJ99wJ+ht5i7k8TFpzZVn+k4BGJJvcwTKpWj0Id7VjlKdPvwlu/gG833SQtf0Ot8FQm0q9a9moqd6x8lLyCTJJuO+ryIhbIUEQuaAADSmDhYqk79wMOSQk7Wm4EsvmdgueC3l0t9Q90WHBi2A6ydQ4Qrjvc0pJh/VNFZHTF/HoIaoDvRnag9R0OK4VsAj5ww0r0Uh7Dm3g6cQ18RoeCZRY09d/1Uxn1/HFMwPdoZEMjoD+kEIeJgMCJDGPSv3LNwnNox1CsyvFVyEAcEgpA0isc3Z2MOfrdq1sq0ImCD/5LlVhK+10KobzDvtwVrptdmAHoxl8MYMUQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFcjThARwawNGD+N6FcdG58yueYETXA/T9C0hSxpNyU=;
 b=LY49PLVTxQ6nSjt5frux9aGP0ZEaYiOB4hhy2MSmMmVBUBDu0XhuTdplquQMCGlDXU8SvvJEp7ewho8tzbEpfbOsrxKUtlGYiaL3LknSVMPb7jqZBE/K/K09Ic8zHRHzrkhJ8jDl72DjhmDPRCaz0QAEcckQumQ2cOQWe4t+xqWcGi6VWOgjZx6ek39aKglxHeqbTvvPUSZMNhtq1/2kwIr3+3UdFOrGXo+OPR9DH9XdjaDyfRgI0J5ime3wwcOrYSvttQDa+KRI2tGrCqXRLXuvj4SlMw/sE7gPg9XsdMTPznmUiNdwXvMXtJQ24RCgDHHLFJ1FWr4M8NQBNii8og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5270.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 13:56:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b%4]) with mapi id 15.20.5791.025; Thu, 10 Nov 2022
 13:56:52 +0000
Message-ID: <880b01d9-0544-a052-e435-30933b6f4587@siemens.com>
Date: Thu, 10 Nov 2022 14:56:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [cip-dev][isar-cip-core][RFC 4/5] image_uuid: read
 target_image_uuid
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 christian.storm@siemens.com
References: <20221110124503.274124-1-Quirin.Gylstorff@siemens.com>
 <20221110124503.274124-5-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221110124503.274124-5-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5270:EE_
X-MS-Office365-Filtering-Correlation-Id: 362e8f70-601d-49e7-b74a-08dac3236be5
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9pwTqecN9MriJUqHotQuspgV3t2+OU70Hm9034bG7D3jq+dzefSUoLhptyXvBWQHmj4ft2K5ubwavUiHKEIAxX89GX+pIIfBUaZ78DyOiM8ALnQ8KpASSUHXs2bHR1bzeusFDy1beV+rBze3GbIwKoRJdMbEVHkdzg7SbtrwmHW7Fq//5FZjwYhG4w58/rD1NhpjHmcZoPI1nTCzBQ3I1qcyFtAuz+E8LSI/yQ0tzZ0kSv3nkEvj9tk529jd+iuhPazV9zHVMYAi72XrBWBYusiRScp4AFSmTnl5DJI3E/g0g1XO9ezQ04t8N29c6vNo0OLILmZXC1wA1XCXSRNUfTVcI5scr7WSW4DEOtMnbqOO8+5RoQzBHHWTM91KrtIkJBqx0Kie07DcDRIyloNTNDuwyOeHGbhtoREcO6cXawS9Tw0Riufvtx9wE4Xwd5dOTJOviEPPxOcw6liUlbF7U7sp+zemmgAdjltl4lKk0Vg1dSwe+Xhk9xVsa8+X7hom8bXoEqQUldE+37tk5vib+rdno+NObbHjTgeMLvWGPghnkRrxcW0OaFNZ5G1doP8krb8zGmdlU1wq2DgLWZAdSaUY85z/SeCcYEwQj3jA1LzPpYdNjbkoTl8YWWfFhCzsHbxu7z+cdSGy7k8xwRnUunzmbBxXZXJHu4wLLUEhge9QGb/BrJdYjMJ2JHVJgWuRAhAkm+CDIQCfl9lXO74oMxMiHC43z0HZx33nKnGc1s5P2XspcQ+/yPrOXwj7ns1AFL3OifL0yzkp7eYWcAbs51E+SB8EfaY1bVGJvaIHNavfhHnroJfIodnC28LlfNQg
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199015)(44832011)(8936002)(5660300002)(186003)(2616005)(36756003)(6512007)(26005)(66476007)(41300700001)(316002)(6636002)(6506007)(53546011)(66946007)(83380400001)(82960400001)(2906002)(86362001)(38100700002)(31696002)(31686004)(6486002)(8676002)(66556008)(478600001)(403724002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UHNBQjRiUVcrM2lmS2g3MlRrbUMwWU9VeGQ2Qmk0ZnBrUS9QL1dvdEt3aStF?=
 =?utf-8?B?RE4vR1EvTmxUeERyM0U4WkxhL2ZHYS9ZODFmeGIwQ0FudHY2bGZVYlZGRjlO?=
 =?utf-8?B?cmlTYkRTbWgvMWlVWlhzRnQ4L2dzNUpTZCtwV0dPaTRGdk5ueFBJR1Fla0Q1?=
 =?utf-8?B?cUJEd2JwaDZOWW1uc2RQSXQ5Zkg5cTRTZVJoM0l5ME12TVc3VWF5d3lzT1Ex?=
 =?utf-8?B?cW1Ld2dLTDJ5R0d0UmlGZlNNdWs5WlBldllOYy9CODc5NHBPM3ZxQmxhK3dt?=
 =?utf-8?B?YjNod21vcDdOVTgyNDZNNzJ5WGJwa0pxU0tnd2tLcEVnS0Y2dmtMUEM4cEhR?=
 =?utf-8?B?TWs0NW93dUk3Z1dibW9nemhZUThyN1pkZlV4S2JSRWFyaDVaZ2NyL1F2R2FT?=
 =?utf-8?B?VmJGeDU0aVFrNEtzdVZXaVlhMktOSGRnMS9Kb3NrYWRuRkIrejlCdmcrdjJ3?=
 =?utf-8?B?RXlONmE0TXBQSERyNUZBeVo2Z0ZGREdxTEE1SnArNWR4d3ZEZ0ZNVEFxaitE?=
 =?utf-8?B?N211cDRmbjFYMFpEenFPamFjc29QR3BCREhjUXRoTVU0Zzd6TnkrTmJkN1Ji?=
 =?utf-8?B?cmhqdE91WkgrN3QwZmtJeGM4a2g2N25sMXZkbjI1TWV4RlA3bjFCYm42WWV3?=
 =?utf-8?B?TFNhZDdDYzRzQUJWZkJuK1ZMa28yZ1ppZHA0S0dUc1gyeXd0ZFZoTUVxVm4r?=
 =?utf-8?B?b0pKK2MvaGtDL09ubFJaaE8vd1d2RnZxUk1iVGYvbkdOR2dMUXZhcG1SVlZJ?=
 =?utf-8?B?Q1lJYUc3UWZJdStJOTV2blBWWS9KV2lmTm1UM3NVT0g2R2lia29pMmdURmV5?=
 =?utf-8?B?ZDZSdVFUVDhyUmlPNUU5NzEvbitnM1ZvUjBxSUlrVHNtdjA0OHErWlNaMHdp?=
 =?utf-8?B?QXY5cUMrNDZHeHBpbUpPM2xWUGlqN01qUEJkRllXNyswQ1lzS2kxRlVoMHpK?=
 =?utf-8?B?SUJObllTV0hmSXJYdDRRV0FRNVBjT004UEZFYmU1QWdLRVNOZ3ROdENsWDln?=
 =?utf-8?B?VG5tdWhoOVA3T1Yva3ZISjRyMmF1ejBJcXlhYVlac2FvaDNBeW1yRFZtUGpW?=
 =?utf-8?B?d3BDcFJudk12UG5xUG51NzlWVURENWlIM3ZLa3ZqdWQxUGRqbytiRDNOU3gv?=
 =?utf-8?B?eXpEeWRFUlZidHBjOHFwQWdFQWJmQTFDdFBGajFxOVVDUzBHVjZ4VUZ6RVc0?=
 =?utf-8?B?RlBYUjhCNHVMb1Q3UzIxOEgwWFkzWExmNzNPQjdaaEJOUFBRd0J3ZVdxMWo2?=
 =?utf-8?B?UmNLZzVFYXZIemRhd0hSWGw0T0dJQklLZ2NyVzhpWjViV2FOUmlJNy9JVVdR?=
 =?utf-8?B?UENWbEF2bVRQM3VCOGlQWml3TWNpZjA5RFlQS2dnaGhMZ1NGb0NPZ0lEWVJv?=
 =?utf-8?B?OVJlQ3RJbUpRYmdsRCt3RElncW5STmIvTnl5Vk5EU1JVZG9KWktPQ2M5cytp?=
 =?utf-8?B?Z2Jyd0tZa1NLREl1SFJmV0dvZnA3cTFsQkpyWVBRVTZkNGxsRTcwb1pFRE5S?=
 =?utf-8?B?akJVM1lMaTVzWXcvZ05PZ2hMTXR4SXRKYlNLTVYxa2h3Q1FzSUgvbkNFNTFE?=
 =?utf-8?B?SnIxRHNvb0ZUcko0Q0krdC9SMTBCaG9KYjlHNmRuY0p5Vk5XMHRvRE0xa3JV?=
 =?utf-8?B?WGlnamlnT1Y0eVRnMjFxSU1KVEtxeGx2YzBjZnYzaVZJSVQ0c3ZjT1ZKVTZn?=
 =?utf-8?B?djA3T09CTzRzV1RFcWtSRnlXbFRQZFNMV3REbW9NaU9mdHNTQXcveStyTnZC?=
 =?utf-8?B?b2x5QUZra0tmejhpTVhQSENiRTBhN1FkTlJCL0t6d2xpSWxxNDZHSnY4dE5j?=
 =?utf-8?B?dUozaWl1V29qaFpsemJNUkFtdVRiRU5MRnNGYSs5NFcvM0J5V3dGOTdsVllY?=
 =?utf-8?B?dVBRbGN4Wm4vT1RlWHBWaTZuQmdtT0krRnl3bnRpRHpXS2JOVmQ1TG12czZl?=
 =?utf-8?B?L2ZNVGZJNW15WjhmUjFhcWtnTHFjVnFUZXdXOTJMdGc2OFJXcHAwaXBtRTFh?=
 =?utf-8?B?eVoxMS9KZ0cyVCtqeEVOcE9nTU9nNmFXcENPMmc1QU43UStLeXlMa1I3aC8w?=
 =?utf-8?B?K0UxeGNweUxGUHVERGdNQmpXK2RjOWJRS0NZQkQ1Q0tiaUdxaHlHM0RSaXBk?=
 =?utf-8?B?V2ZqY2pEL3hIOFhWVy9GOS9Da2l3eHovRjhSelFmcGdTNFJWQ2xQUXhsRG80?=
 =?utf-8?B?eFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 362e8f70-601d-49e7-b74a-08dac3236be5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 13:56:52.8785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyKjYedyYFElAADSTywtxWL0fI0B4/z44LSoXnTxfKlQ8AphIISyvsQf5PTt9fqbMXxHzBs2NVMQxRriQcO1aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5270
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Nov 2022 13:57:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10007

On 10.11.22 13:45, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This writes the target_image_uuid to the Variable TARGET_IMAGE_UUID
> which can be used to validate a update against the root file system.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  classes/image_uuid.bbclass | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/classes/image_uuid.bbclass b/classes/image_uuid.bbclass
> index 277941b..3e2e3de 100644
> --- a/classes/image_uuid.bbclass
> +++ b/classes/image_uuid.bbclass
> @@ -13,6 +13,8 @@
>  inherit rootfs
>  inherit image
>  
> +# Generate the uuid from BB_TASKHASH to ensure a new
> +# hash on each rebuild
>  def generate_image_uuid(d):
>      import uuid
>  
> @@ -23,6 +25,23 @@ def generate_image_uuid(d):
>  
>  IMAGE_UUID ?= "${@generate_image_uuid(d)}"
>  
> +def read_target_image_uuid(d):
> +    import os.path
> +
> +    deploy_dir = d.getVar("DEPLOY_DIR_IMAGE")
> +    image_full_name = d.getVar("IMAGE_FULLNAME")
> +    uuid_file = f"{deploy_dir}/{image_full_name}.uuid.env"
> +    if not os.path.isfile(uuid_file):
> +        return None
> +
> +    target_image_uuid = None
> +    with open(uuid_file, "r") as f:
> +       uuid_file_content = f.read()
> +       target_image_uuid = uuid_file_content.split('=')[1].strip(' \t\n\r').strip('\"')
> +    return target_image_uuid
> +
> +TARGET_IMAGE_UUID = "${@read_target_image_uuid(d)}"

When is this evaluated by bitbake? Only on every access, inside a task
context? Because the file it reads from only exists after
do_generate_image_uuid, obviously.

Jan

> +
>  do_generate_image_uuid[vardeps] += "IMAGE_UUID"
>  do_generate_image_uuid[depends] = "buildchroot-target:do_build"
>  do_generate_image_uuid[dirs] = "${DEPLOY_DIR_IMAGE}"

-- 
Siemens AG, Technology
Competence Center Embedded Linux


