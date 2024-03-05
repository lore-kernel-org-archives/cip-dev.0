Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B354C54E41
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 14:33:45 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.77])
 by mx.groups.io with SMTP id smtpd.web11.24569.1709649214311182606
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Mar 2024 06:33:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sBR8++Bw;
 spf=pass (domain: siemens.com, ip: 40.107.7.77, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpcEEiRL7W0wwmVcRcb1b5TtHniM9B//JgdZ3KUuGaWzmqAypxtFWiSs2u+bUFfV+vxtC8qIkWSzmhMEzc4QYIEcRqusVhk44OVrTEZ7XA4QGwuWcefJaDhIGg3TT9YedQ0KBVM0/L7ynKWrZm9jc5g2G6GIVdA3vH9N6rsQRrFBqUTOTjUdFlEyEB2FGO6H0ib8R3YqyDFyQ5TIznNvhNQ1t+2NrFW6f0cztcvzrqwg+BHDF8e7oNc3flIyaztcbNLRZLTkY3DsvKV3j+xWOBDrasb91eezqtCWeVqmkTsGWDcRWhnwVFNxmx+gwEvT6bHwStTtl9widjFJpeY9xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6frtWN2aNex6yY8rsbADKHAJt+gR2JzKE03vgzBn0nk=;
 b=VnDOzgoLCNGLOEwvyLnykvrxpjZdHbelkIB5VffRPYfG8NVsWG3hWYoFwewvzfSAVdzri3RNBlJMoBBlEVCOz0wQuxrt6wNUO5CJsOWs10j4hWpUZidXCEQ5anMkN7u8jPn6lOuBgGvNeTpM95epGjHvEiyAQiCvPjN5RpVlVpa55mf5aReRsEgKIdZPr0Rt6Clo+AUjkkbtpyWvb1jx1DLKFuXWUQi51ZnPOpf8GFr3YEBXdjJLqLwt+mVUFzq1HeODCXKPOytbKcBneBxre8IjwXruFIOsNVuV5vfGTYqdCnuvb6O+lhmYSfwlU1lmwxssB0i+XWFtFqJzaRwkbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6frtWN2aNex6yY8rsbADKHAJt+gR2JzKE03vgzBn0nk=;
 b=sBR8++BwLAPwmI8NU1PqnMe30LX0cVHNo5MbDr6+2fzt5SqSANo4mjSXGnen5UNUJ27nWcUbicKcAqyzCQepF44l17TAzY0P0I9/GqBJIA2+i9JIWn2qtUUcvRpiAUXNTOkz9FXHjUQtPJ9wZscMTsm4YjQQ/E34xJICB8uM8855Eo70WSQxHOqz+AtxUlG3gXmlBMIV13zxNEi0Zmrn0/UnhcFHrI7NQw8Trjv8NiTMQJ0oIiyfgGV17P0yEvoEbClT8hpb5ZNbFTGIuznI9IVlDV9gw4JDoN1SNopm97LDaQIHFHG0YJSApvkKJ+MuRg60GicEc32iJn4bFK4OOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB9PR10MB5331.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:337::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 14:33:30 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7339.033; Tue, 5 Mar 2024
 14:33:30 +0000
Message-ID: <76dc4aef-74d6-4110-8d5a-e2828dfbfe65@siemens.com>
Date: Tue, 5 Mar 2024 15:33:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 1/4] swupdate: check output of
 sign-swu
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 felix.moessbauer@siemens.com
References: <20240305110311.2073425-1-Quirin.Gylstorff@siemens.com>
 <20240305110311.2073425-2-Quirin.Gylstorff@siemens.com>
 <9b294320-d609-4b93-9675-627d26f69b46@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <9b294320-d609-4b93-9675-627d26f69b46@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::10) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB9PR10MB5331:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e2c4fe6-421c-4dbb-b4cd-08dc3d213a58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6YObyRBrEBm9os0ooJKcXx3CgxCImHA3tdhKDKrBuZmukG32BUCFVi1ufDW0slhoLGPoXpEA1sWS8TChoczYRlWuTSzkyMP36hdDMYdtp1cfT9QdWEwQR5wpK0MNccJPv8C5exKPvTcdyhpKdRcvh9DVTi2dzU3CbV0o+8xKbkOr/DhG1Gs8KOuo5GrC1xsdE2aHTwcAInDNNrVrLeKtx75OmUCB/9iNbpXmHO/Dv5kqLcUP4rTxfMlJyJPHjpGhtD+wb7SpDfYjoE7NlC+z1mtBpAclaUX0DQD7rGUGMEKqTjGgWiPsYEfNohZtqMRYRqgDZKEOaeGY2CgM/FcOso4z6fmsFtST5IRCwK5qelKCPN4ppI4SiTpmhaYO29LqGwiGfarVo8vL1jiNZh+k1tPPO3F96Q1u2nA4VY9NVGzgPjIbrLi8JAoMSi6MIZqF8mmPnAvDxu+GQgwN/rv8kcgYogBemdWbyjRWOTE1BfsEaDenD9DMLKQQ8TOD2iNhHxVud/0pQDsA0GDCo9Dv+qEBka7qKb5Lf+WEV1TcenT+ENAtRTIg+JjACk1nKu3VtgA0p9CauubThj+/j6t0a7ac5TxBNSK2K5HGUoMJPwhg9tkwnarnfD8uXshumsp2bCxpRkPNDBbxEEde6AwQ6Xjptard9/ZIqepEU50EPAk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?KzhMdmgyb3pIa2tYZFJiUkZwUGNlZ3hpbWNySDhTU0NYZjB2UlBVQ1l3WFlK?=
 =?utf-8?B?UGZQL0JMM1dnc3JacVFLYVJEVzBvSTZPQ25mK0VqU2U5eE4wYThPQlduSnQy?=
 =?utf-8?B?K3BpN1JmSVI0QVFTWTJwWWV1aWk5d3ptMEc0NTBUZmhiZ3J2UkcwWVRTaTF3?=
 =?utf-8?B?NW41d2RNOU9kSFlabmFyOTJjdUVQZjVRdlJxQ2pEQ3BpYzNJRU5vNnJCbisw?=
 =?utf-8?B?K2pGeEtjOEJaVlR6YUtRdm5oeVVWZytkWUlrVXB2Nk4wOVIwQW1xbXNuajFo?=
 =?utf-8?B?Y2tYZXlwT0ZkbDhqNTlHTXJ2ZFhNNmowVThjeHdhRktJdzVRazNxdXhaZ2xp?=
 =?utf-8?B?d21kTW9wWHhJZXpWdVlVWGtGL0M3alFSM09pZnMzUXRvTS8wQWFndVp0K2d1?=
 =?utf-8?B?L1h1T1kzbDRubUZKYndRVTA5d1FNcnNENjBVYng2bC9CTEk0UEVQc3NyZ0ZU?=
 =?utf-8?B?K1V3aW9UNjZLY0trcFlaZGMvd3BER2h2OHZlMXlkSTFST0FCMXJxMFVJR09a?=
 =?utf-8?B?VHRHODhXZ3BRM0thSFFXZHQ4TmNkelByV0c1Q2x4UmNHaU5rYzRGR3Y4am5p?=
 =?utf-8?B?OW5OWkRjbGlBd3o0Nks1WGFQeDJ6YVljL3hTOWJoRHFNYnZ3ekFKd1drdG0x?=
 =?utf-8?B?aTRKcVgrSG4xQ2lsMEIrZjJhVnpMV25mZGxLQzNYNGtJVmpVRjJMQVZOaTV1?=
 =?utf-8?B?ZXkrS3lwcm5zeXN6OTVORWt6VVBrTWZtd3htK1YySE94cVdnazhVNUZuVzRx?=
 =?utf-8?B?ZGlVTEZPUk9DbmNYS295d3lqaVN4S1ZwVUMzTTczcjBuTWJBTi9JcXRlT0Fn?=
 =?utf-8?B?NVVXamFrTnBWYUM0Rzc3eUNkYWtDY2dmUUl3ZGdZbUpCWCtjRWtBTk1OQkxx?=
 =?utf-8?B?MWNZWDZKc3gxTTlVd2FYVHlQazBXK3laWEh1bGFVeVVoMEJnY09ONG1kaGxP?=
 =?utf-8?B?bkxEemYvSCt3UnFwcGFCdHZIb0dsdDByTDA5c0JHSlg5ZUszQ0dRVGpEZHJq?=
 =?utf-8?B?cUZBeWw1ZHltcjBId3ZqbHI2YjBGcFpoU2tLM0dySzBhdnJuU25iV1JZZnI4?=
 =?utf-8?B?TTEyNGxVa1g1SVVnVUpuWUd4eXZTcW5FV2t0TTNqSzdXMkV2TmxTS3JmUVRj?=
 =?utf-8?B?MHJQK1FwbXZRaWNuYlpPM2FIa0RuY0hIK2wvZTFqSERjcU5NMnlpTjJWenRC?=
 =?utf-8?B?R2lNR0pEY1JXU1hMV0xveStIVjg4V0xwL2xMS1doZkwrOC9qSlNiWFRDcjFR?=
 =?utf-8?B?dWJYL2hFbVFVVjA0MmVYTVZvOFkxcW41bG5ZRzBNMjhlWlJ0OU5HRk1RZHU4?=
 =?utf-8?B?eHJuTkE5VWZkaFJqK3RTTVU0TElteGlPV3FxTStWdG9YTWhpV0lOOEgwUDVu?=
 =?utf-8?B?TmNuV3hBdzJadjRlYWRycVVpTlIwTTJ1MUF6emprSUErL0ZmY0V6L2Z1N2Ru?=
 =?utf-8?B?UHZBSFdVOHF1QjRPYUE1THB1U2hFMVNWMTBnbUZxMkhDdFhmU2xVa2p0Z3pn?=
 =?utf-8?B?WVZYWm5kd1NzR1VJQXdGbVlhMjVPZ2xidkV3Y2h4VTdNTHB2Zmo0OGM3SXRw?=
 =?utf-8?B?eTNKWGI0MjFscytMeGhpNEpOVEJUWEw3WFk1V1c4WTVCd1Q0aTRiM0hGYlVs?=
 =?utf-8?B?OWJaMXgzUzA2dE9PekU2WnJKN2VGaFpjQzhISDdYeFB6MEw3dGRoakVzZGMr?=
 =?utf-8?B?dVRwTHp3Z0hxU3p6MG83UHd0bDQ1WERvNFIveXNrMzI0SlJSbW1ITUpGNzQz?=
 =?utf-8?B?bnBJR21KUUxGL3E4TG9MN2cyUkxKZ21xV1c5T09LUDRmWE81ODRQUWl4Z1Jp?=
 =?utf-8?B?Tjc3dlN5L1RHQWkvMTJweTIyV0dBNW5SWjFueStWZ3U3NjJnL1RPM2ZhZ2Y5?=
 =?utf-8?B?TGJCY0h1TDArZkNlbndwQTJTZ05uOWZNUnlkNlJkb3JWcEE1RjV1bzh3OVBZ?=
 =?utf-8?B?UWFmMGNpVzUrTVBHcEs4ZTVnKzN6WFAvaVVaQjFpRW4yaHVYN1BabDVtLytv?=
 =?utf-8?B?eGhzWlp5NGVVaFNoNTJwVjlvQi9rNEFXNGZ2cXU3Y0xJaU5ISktja0N1ci9y?=
 =?utf-8?B?Ym5JSWZuUDcvalBTNXRydVVSU0dISlBIV0ErendwRmZSaDh6UnJjUDduVkho?=
 =?utf-8?B?bVdabkIvdXI5MExjRjBUMlQrdUJrc1RtVm1lcmZpdVlyR0tKR2ZtNU4ya2ZL?=
 =?utf-8?B?aXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2c4fe6-421c-4dbb-b4cd-08dc3d213a58
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 14:33:30.2832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qko1aHlRK3JElPhRLlgm//lJQZfBEMG4zvBtcQMBHWaVG29JhQiRKXSTfucGdvnZtdWpsVQfLLuUdUb8HZitsStb7DOApxUgeouNFF1mI1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5331
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Mar 2024 14:33:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15228



On 3/5/24 2:50 PM, Jan Kiszka wrote:
> On 05.03.24 12:02, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Check for signing errors to avoid an unusable swu file.
>>
>> This also moves the siging out of the loop to generate
>> the cpio archive *.swu as the Messages from the signing
>> can lead to errors in the archive generation. The cpio
>> options are no longer using the short form.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   classes/swupdate.bbclass | 43 ++++++++++++++++++++++++++++------------
>>   1 file changed, 30 insertions(+), 13 deletions(-)
>>
>> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
>> index aaff072..c62f43f 100644
>> --- a/classes/swupdate.bbclass
>> +++ b/classes/swupdate.bbclass
>> @@ -191,24 +191,41 @@ IMAGE_CMD:swu() {
>>                       "${PP_WORK}/$swu_file_base/${SWU_DESCRIPTION_FILE}"
>>               done
>>               cd "${PP_WORK}/$swu_file_base"
>> -            for file in "${SWU_DESCRIPTION_FILE}" ${SWU_ADDITIONAL_FILES}; do
>> -                if [ "$file" = "${SWU_DESCRIPTION_FILE}" ] || \
>> -                    grep -q "$file" "${PP_WORK}/$swu_file_base/${SWU_DESCRIPTION_FILE}"; then
>> +            cpio_files="${SWU_DESCRIPTION_FILE}"
>> +
>> +            if [ -n "$sign" ]; then
>> +                if ! /usr/bin/sign-swu \
>> +                    "${SWU_DESCRIPTION_FILE}" "${SWU_DESCRIPTION_FILE}.${SWU_SIGNATURE_EXT}" \
>> +                    > /dev/null 2>&1 || \
>> +                    [ ! -f "${SWU_DESCRIPTION_FILE}.${SWU_SIGNATURE_EXT}" ]; then
>> +                    echo "Could not create swupdate signature file '${SWU_DESCRIPTION_FILE}.${SWU_SIGNATURE_EXT}'" 1>&2
>> +                    exit 1
>> +                fi
>> +                cpio_files="$cpio_files ${SWU_DESCRIPTION_FILE}.${SWU_SIGNATURE_EXT}"
> 
> Can we use a local short-hand variable for
> "${SWU_DESCRIPTION_FILE}.${SWU_SIGNATURE_EXT}"? One that makes the lines
> shorter and more readable?

Sure will add in a v3.
> 
>> +            fi
>> +
>> +            # sw-description must be first file in *.swu
>> +            for cpio_file in $cpio_files ${SWU_ADDITIONAL_FILES}; do
>> +                if [ -f "$cpio_file" ]; then
>>                       # Set file timestamps for reproducible builds
>>                       if [ -n "${SOURCE_DATE_EPOCH}" ]; then
>>                           touch -d@"${SOURCE_DATE_EPOCH}" "$file"
>>                       fi
>> -                    echo "$file"
>> -                    if [ -n "$sign" -a "${SWU_DESCRIPTION_FILE}" = "$file" ]; then
>> -                        sign-swu "$file" "$file.${SWU_SIGNATURE_EXT}"
>> -                        # Set file timestamps for reproducible builds
>> -                        if [ -n "${SOURCE_DATE_EPOCH}" ]; then
>> -                            touch -d@"${SOURCE_DATE_EPOCH}" "$file.${SWU_SIGNATURE_EXT}"
>> -                        fi
> 
> Why is this timestamp tuning no longer needed with the new approach?
I moved it in the for loop for creating the cpio container. That way the 
timestamp tuning is in one location.

Quirin

> 
>> -                        echo "$file.${SWU_SIGNATURE_EXT}"
>> -                    fi
>> +                    case "$cpio_file" in
>> +                        sw-description*)
>> +                            echo "$cpio_file"
>> +                            ;;
>> +                        *)
>> +                            if grep -q "$cpio_file" \
>> +                                "${WORKDIR}/$swu_file_base/${SWU_DESCRIPTION_FILE}"; then
>> +                                echo "$cpio_file"
>> +                            fi
>> +                            ;;
>> +                    esac
>>                   fi
>> -            done | cpio -ovL --reproducible -H crc > "${PP_DEPLOY}/${SWU_IMAGE_FILE}$swu_file_extension.swu"
>> +            done | cpio \
>> +                --verbose --dereference --create --reproducible --format=crc \
>> +                > "${PP_DEPLOY}/${SWU_IMAGE_FILE}$swu_file_extension.swu"
>>   EOIMAGER
>>       done
>>   }
> 
> Jan
> 

