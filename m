Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.18])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.29022.1793862210430318604
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Nov 2026 23:03:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FqiHMrH3;
 spf=pass (domain: siemens.com, ip: 52.101.70.18, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhIRnpe4BvYB7JRyiBcKGp0A8tjtk201xVKC64vmV+dpGPD1I3s66dudk+o9u+UoAuG3EQg+/NDul7j5Fm7FGNGBmZJjCO0Ix0v0LaYmPawzXI7cA3nHSmkjRrYEt9K1UH58IK6T+lOkyI5BhRQcXtIyjYrvp6mHeAmP9SfENpbJ6KN8NuvDR2bjO6dCPIArGOBUfbVtxth/ghvixHaNMCNeoCxm1RzjU4LPY6zUdA/Px8x+SLwaM5JkycFflBeeM7GDupFN7vGbk2lzsZuTgfJR+ETyb2V0ewS80xwn9bRcu2zHeENAhkNomZ2GbS1daWrzcDKy5qCLR05g+qGxEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uN5EHk8R2AvdVkp5y6xEvJ+v5t6OzObU4cJ7jDW4uPA=;
 b=gQff3N+lcCrvnXysqC1PdWNhoH7B5yAzVinKUJ02Jcy3zKpbDIJBPxdyoQyVoH/+cY4QtEgOhG3PnVH5S6E4CFUIAY1g94CyYGHIDmwERZKsZNhqTMt2P3A5jqocEDA/BG74SnawAXJlZ6BV3/gqZ9kOkd42DmWddZ+ulL1v2ryKSAzYyTsNQUrJVY9w2uCKFwU2Hhh0g6vnV6A2dpEUxWTnZtjgSe869ZjJy1Kyd2x071Fs+2negXvtLKl+bctgFe3E9caKl0ex+fYHGD/76+IcJoBBbJ90CPUHZyX2IM0VvaZPOY5Lk3ErCeg2es44/frk2yEVPWJx5jyxPK+FOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uN5EHk8R2AvdVkp5y6xEvJ+v5t6OzObU4cJ7jDW4uPA=;
 b=FqiHMrH3myoyEeTGpLU37plMRggdbQJkgatncv83X67vJAfcaEwzACjgHaEOnheqAyUSkJ8ObU3vgpgDNxdVd0i7MQEmU1lfcpsLTYMGcnwbTp+k275Gk/Xg6UsofTBSsKBybtykmQA61M0xYdFyKY5/Cbe+ikaGXfCY3l1XA04CAdbnb1og8Nl7FJvOKqHoTA2qSVZwipZBbwNYSmblmJ3nKpLpLan66iWBGT3sLYDarkfmBB3mdS2O8rlPYu+FZmHPCH89QL+o68TyTQTbOTWBaO76VbQR1YQRigpk/Um7y5M39IhFelan6Z1FiWUuCrt4yb9pIA+d0MPjNefstw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by BESPR10MB198664.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:b10:13f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Thu, 5 Nov 2026
 07:03:26 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.003; Thu, 5 Nov 2026
 07:03:26 +0000
Message-ID: <61cf558b-06fa-46f1-8249-bb8378f715fe@siemens.com>
Date: Thu, 5 Nov 2026 08:03:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 11/12] doc: document dracut
 initramfs
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20261019102541.672620-1-quirin.gylstorff@siemens.com>
 <20261019102541.672620-12-quirin.gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261019102541.672620-12-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0385.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::10) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|BESPR10MB198664:EE_
X-MS-Office365-Filtering-Correlation-Id: 58236934-ac14-4e49-d492-08df3b0ae398
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|4143699003|261026130827099003|11063799006|56012099006|261021130227099003|261021121427099003|261021135927099003|261022075727099003|261009221727099003|261026135527099003|261021133027099003|261009220027099003|261009223327099003|261009223027099003|261022105027099003|261009221227099003|261102123227099003|261026121527099003|261026140227099003|261022115727099003|261028144727099003|261021123027099003|261022113327099003|10067099003|55112099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: A/D2cqvA3vhiYH9yzvkUDsfk9m/oAa9EynwAHhdNNbjC1GozvAgbtOF4kH85uMTeWM4mL/xYTsSlN4tI4lMg8LD8c105oNKMm5WXPFcSBi/j6EebRuZcL6ckUsjUwqKrUCAQXy64BzdU+uFHUImKhBkBg4iCxMSibENjHTQ+IgBk2AJk4bDfKbDhCe7OmuSLeUpN5x8B7VVAbdhCCyvQKz1/D7BFKxpxZzxDx/LTTQriG6gbKt48RK4VsQlAXquvqxoP0RpEkxqQh64r4uxZzkZOyHzIR66TFltR94RHBgm1kI2JJt1Vp5LSyprc2Ex/9jbPJ6ZCIxLAhOawpaP8lQmwAizx0bHQY2jHfXVKVMxYRuqgQ/j9hEx4HjnGzIZ3dkHYmxYpGdj60Cbh0HXQo3rmsRqOOyuVvky1+99wLX8mn71ENUQHgBTHElaHLSY0X/YoppQGjqW3pN1SUZFDtQPg/XPH1LTHM2sAeo29UBHUbrzges+aHcTpppMVo9kO7JoUI6c32aNcLwEmg4AztBqP38g+5MQulbjk/LHr3K5F6Dyaaqn2w2MYRYbohw48BO/U+sLZvdeb0AB5UQnejWMIlnPU0kkY45gwH+jzTGhlun9uDXlGT7YqvSBHFZJ6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(4143699003)(261026130827099003)(11063799006)(56012099006)(261021130227099003)(261021121427099003)(261021135927099003)(261022075727099003)(261009221727099003)(261026135527099003)(261021133027099003)(261009220027099003)(261009223327099003)(261009223027099003)(261022105027099003)(261009221227099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022115727099003)(261028144727099003)(261021123027099003)(261022113327099003)(10067099003)(55112099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVpaK01sQS9BZkJucHFiYVpqTDE4cUNCVTZoRWVsdDNUMExNQXdYL0xjcFlY?=
 =?utf-8?B?SjRiUTUvTlVQZmJmcWZabUFGUUt1TGhrNE13ZDJ1bi85emwvUXVNK29UV3pq?=
 =?utf-8?B?ZDc3SGEvanVJZTYyQThhSnBpeW5TUFFMbG9KMXJJNExENlB2K21NUWdRQWo0?=
 =?utf-8?B?cDlJYjVwUzIvdHRWSjdyRGxnWUpyYWVycHNjZ1NHRVJHTEtWWCtReDQxWSty?=
 =?utf-8?B?L01TSFZYOTNqS1daT0ZsMTZta0hoenlDY3dzbWZxREhoWmZ6V0RpT0tZZm15?=
 =?utf-8?B?Y3dOSUZJbnlkSklON3hHRFNBUmlTS09vV3Zjc3VJVThOTk9tazVobEdQb2d5?=
 =?utf-8?B?UGY1K3pGUm5MUW1kdDBISDlLTTNvQlU0cjJZb3gwcFlSSHZKRTNYc1VyY05k?=
 =?utf-8?B?eWlEWk95dzE4V3VmUkVJQlJLL3Q1Wkh3KzFSVnlWUGlvTGhOaFhoTnUyMkdZ?=
 =?utf-8?B?TU1mQm9VTVdHZm5VUmQ3U3VsWFM0ZFlRY3hzY1ZDbVBobjVxVUd2cTY4OUV3?=
 =?utf-8?B?Y1F0bC9HNlVJck5xeGZudkFGMTRwLzJydGxNOGc2S0RZMnpOaU5ZQURqMmV6?=
 =?utf-8?B?dDZhalNCcEhpN2piT2hYWlVHcmYxc0hCdGFsNjZvZHZKRnFyVzM1RlJVREdP?=
 =?utf-8?B?YXMybmM3RnlaMklQOU51K2piQ3ZIL3JDUDhSRzBrdG5ZSDgzSHlaS2lEaFFu?=
 =?utf-8?B?MWI5NmdCeWp0YzhNOGt3YWp6VzFkNnoyWmdsMDFGTGVzdGxMRXlDVm95QUJV?=
 =?utf-8?B?VnlSMUpxVU1paW90VDUweGtoRFhNZUtsbUllQWMwT1R4eldIeW5nNkJhZkNm?=
 =?utf-8?B?NWxvVXZFeU51UzhKNUU3Q0FXc2p3SWV2WWxpNlpqcmhCNUNZeU5DU2xXZThu?=
 =?utf-8?B?d2xyWi9zWTJ0TGtGQXphcWVLdTFuM2M4elNDeDN0ZVdLRFZTak9IQ2dUcnNI?=
 =?utf-8?B?Z1AvOHl2M1pSSVFxb3R2dXpQTVhVTmZVb1RveWpQNFdMUmtKTTE1eEtPbVN1?=
 =?utf-8?B?b0x4MHNpcW9yZ0ZPUmd4UDJnZGV5TVdWditMRGk1NXdnWEFaL0RnUHFPaTRi?=
 =?utf-8?B?WjEyaTVMMWF0TUlHWjlzaE5wdlJXTG1nblVYdnRNcC9RRlBDNUFOL3U0Vmlp?=
 =?utf-8?B?TGEyUjQ2dVhuUXFDenNHMTAzYjZOV0FmWmFLQ3NkQmFFZDdxbmMwWDFocmV2?=
 =?utf-8?B?UFdYWkg1U05RSW1GUnZza0sxUkFKbFZ2VitWUVpYUmJMOFJRajUyRC9MRVJj?=
 =?utf-8?B?SDN3S2ZXMFo0bS9RVm9ReUpBRkY2OVdUT2x3VXFOZDcvMk9SbGV3YVhuUGVG?=
 =?utf-8?B?VzBmR2JrSXFhd20zVkw5TzdybmJsK05aN3pvVjF3VHhqQWNXWnFiK1JubS91?=
 =?utf-8?B?WEVXa3FWaWdrOU41UlFTUzRWYVJnUUk0QnZsL2VvYWdDckZ6MWNpTVRZS3RH?=
 =?utf-8?B?Y2hwOEt2V2FUQWdneXJUS3hGSDIyazdMTHFyZlBOS2YvV0xqUFJvaWZPRkhp?=
 =?utf-8?B?Vjg0YTVWVnQ1Q05wY2RHYWJrN3pXT08zZ3d6b0RlVWk1NjZNNzRWQXVFZnRr?=
 =?utf-8?B?UHltMnd5VUhXeUVYSFE3cVV2R1l6NUtYK2ZFb0Y5Q2lVTzhLajJGTmFVK0tu?=
 =?utf-8?B?Zk51UFArMFNKN3JNZUk2TGVCUzZ4OXp4UzZLU1VQdnpFQzN2Z25zYWtUcW1X?=
 =?utf-8?B?SFdnWEJEZVlTN0dlN3ZSbWlQZjRIRWtJV28ySDhxUGxlNEJEeHV0RkJPQ212?=
 =?utf-8?B?eHdvMmtKYThZWEJCYVdwRitaZE5CRnM5WTRxeDZJSG5SUHhTQXhmakNmODNs?=
 =?utf-8?B?SFM1VDZVVFlkelpIUnAvQmQvRHBqQ3h6aTNnNXVDS0ttYXpPZVczUkp0VlRH?=
 =?utf-8?B?SGpuSGR6YkY2cERMbnpYT1hYRlByM2NydXd4Q1Bzelhna09HNFEvRDBlUE41?=
 =?utf-8?B?anA4NlVVMnl2WjJ4MW1BUFVjTnNxNDRhWGw4WVRlQ0s5aHhmMFl0S1MybTR4?=
 =?utf-8?B?dFE4U0NmMnJEMS8rRU9RdFV3QklNendwb0lLTW5PQWpyR0huWjQwaVBJeS92?=
 =?utf-8?B?bVZ4SFlMaGc2a3ZTYW04QVJIYllrRUtvd0RHenp2VjBEeGt6M0IwaUg4VVhY?=
 =?utf-8?B?V2prZ08wWU9RclhzYitsZnZMbFpaNXROTzFGK1NnVFp4c0FlWncyNzVCbDNB?=
 =?utf-8?B?bUdQK084NTZLUzF6enZHVzZ3VzY4NUpEbkJ3NUEzeTBLelpkTWZLU0E4S0JJ?=
 =?utf-8?B?YXRNQm9qNU1pL244LzBhb1BoeUoxNUlndTdZVHE1Z3Badk1pZWY5M2U4QTNt?=
 =?utf-8?B?MXpWLy9QRWZ1YWlRcTVLSGhCV3dtRlJpam41SkNNK1ZKUmxsSXJRZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58236934-ac14-4e49-d492-08df3b0ae398
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 07:03:26.4917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCqbtBeQfHasbO0YohMiJNIXF6jeDlUaW2/es6EXR1Yj0HJCOHRYkjQVm+kl5dLlfBwNJBwf8ZcZdyec6qqHgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR10MB198664
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 05 Nov 2026 07:03:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24643

On 19.10.26 12:25, Quirin Gylstorff wrote:
> Describe the dracut initramfs, its modules and configuration packages,
> and the dracut-specific behaviour of factory reset and secure boot.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  doc/README.dracut.md        | 99 +++++++++++++++++++++++++++++++++++++
>  doc/README.factory-reset.md | 46 +++++++++++++++++
>  doc/README.secureboot.md    |  4 ++
>  3 files changed, 149 insertions(+)
>  create mode 100644 doc/README.dracut.md
> 
> diff --git a/doc/README.dracut.md b/doc/README.dracut.md
> new file mode 100644
> index 00000000..2a59cd08
> --- /dev/null
> +++ b/doc/README.dracut.md
> @@ -0,0 +1,99 @@
> +# dracut-generated initramfs
> +
> +isar-cip-core can generate dracut based initramfs images instead of using initramfs-tools.
> +This prepares for Debian 14, which switches the initramfs generator from
> +initramfs-tools to dracut. It is currently supported on trixie only;

Not on sid or forky? Why?

> +`cip-core-initramfs-dracut` is skipped on other distributions.
> +
> +## Build
> +
> +Add `kas/opt/dracut.yml` to the kas chain, for example:
> +
> +```bash
> +./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/security.yml:kas/opt/dracut.yml
> +```
> +
> +The fragment sets `INITRAMFS_RECIPE = "cip-core-initramfs-dracut"`. The distro
> +configuration derives `RO_ROOTFS_VERITY = "1"` and
> +`INITRD_CMDLINE_STYLE = "systemd"` from it, so setting `INITRAMFS_RECIPE` in
> +`local.conf` is sufficient. The latter makes the efibootguard-boot wic
> +plugin emit systemd's native verity arguments instead of
> +`cip.verity_root_options=`: `roothash=`, `systemd.verity_root_options=`,
> +`systemd.verity_root_data=` and `systemd.verity_root_hash=` (both pointing at
> +`/dev/cip/verity-data`), plus `root=/dev/mapper/root`, `rootfstype=` and `ro`.
> +
> +## What is in the initrd
> +
> +The dracut modules are maintained in a separate repository,
> +[embedded-dracut-modules](https://code.siemens.com/linux-expert-center/embedded-dracut-modules),

Previous internal URL.

> +and built by the `cip-dracut-modules` recipe. Their configuration is shipped
> +separately by `dracut-config-cip-*` packages built in this layer.
> +
> +| dracut module | Module package | Configuration package | Replaces |
> +|---|---|---|---|
> +| `cip-verity` | `dracut-cip-verity` | `dracut-config-cip-verity` | `initramfs-verity-hook` |
> +| `cip-overlay` | `dracut-cip-overlay` | `dracut-config-cip-overlay` | `initramfs-overlay-hook` |
> +| `cip-crypt` | `dracut-cip-crypt` | `dracut-config-cip-crypt` | `initramfs-crypt-hook` (systemd backend only) |
> +| `cip-factory-reset` | `dracut-cip-factory-reset` | `dracut-config-cip-factory-reset` | `initramfs-factory-reset-hook` (EFI variable only) |
> +| `cip-watchdog` | `dracut-cip-watchdog` | `dracut-config-cip-watchdog` | watchdog handling of the crypt and factory-reset hooks |
> +
> +`cip-core-initramfs-dracut` installs only the configuration packages; each
> +pulls in its module package. Overlay and watchdog are always installed; the watchdog is only serviced
> +if `INITRAMFS_WATCHDOG_DEVICE` is set. Verity is always
> +installed, crypt with `encrypt-partitions` and
> +factory-reset with `factory-reset` (`kas/opt/factory-reset.yml`). The dracut
> +modules are enabled via `DRACUT_EXTRA_MODULES`.
> +
> +## Configuration
> +
> +The configuration variables (`INITRAMFS_OVERLAY_*`, `CRYPT_*`,
> +`INITRAMFS_FACTORY_RESET_*`, `DRACUT_VERITY_DEVICE_TIMEOUT`, ...) are unchanged.
> +The `dracut-config-cip-*` packages write them to `/etc/dracut-cip/`, where they
> +override the module defaults. `dracut-config-cip-crypt` also generates a
> +crypttab from `CRYPT_PARTITIONS`, ships it as `/usr/share/dracut-cip/crypttab`
> +and installs it to `/etc/crypttab` in its postinst.
> +
> +`INITRAMFS_OVERLAY_RECOVERY_SCRIPT` is optional; if empty, the module's
> +default recovery script is used.
> +
> +The initramfs is built with `--no-hostonly`, which `cip-crypt` requires.
> +
> +`cip-verity` does not open the verity device itself. It ships a udev rule that
> +runs `cip-verity-match` against every filesystem partition and publishes the one
> +whose dm-verity header UUID matches the identity on the kernel command line as
> +`/dev/cip/verity-data`. systemd's own `systemd-veritysetup-generator` then opens
> +it as `/dev/mapper/root`.
> +
> +`cip-overlay` is a `pre-pivot` hook that mounts the persistent storage device
> +under the real root and stacks a writable overlay over each path in
> +`INITRAMFS_OVERLAY_PATHS`.
> +
> +## Encrypted partitions and `:expand`
> +
> +`cip-crypt` provisions TPM2-sealed LUKS2 partitions on first boot and leaves
> +unlocking to systemd's native `systemd-cryptsetup-generator` (build-time
> +`/etc/crypttab`). With `kas/opt/expand-on-first-boot.yml`, the last
> +`CRYPT_PARTITIONS` entry gets `:expand`: on every boot the pre-mount hook
> +grows that partition with `growpart`, and after mounting, `systemd-growfs`
> +grows the LUKS2 payload and the filesystem. This is a no-op if the disk is
> +already fully used. Only the last partition on the disk is grown. If the
> +entry is not last, the module logs a warning and boots normally.
> +
> +## Limitations
> +
> +- **Verity is required.** A/B slot selection falls out of roothash matching;
> +  there is no dracut port of `initramfs-abrootfs-hook` and there will not be
> +  one. Without secure boot, the `efibootguard-boot` wic plugin replaces
> +  `abrootfs_root=y` with the verity root cmdline automatically. The unified
> +  kernel image is then unsigned: verity only selects the slot and detects
> +  accidental corruption, it does not protect against tampering. The build
> +  warns about this.
> +- **UKI systems only.** The non-unified-kernel efibootguard path
> +  (`unified-kernel=n`) is not supported and not tested against dracut.
> +- Not ported: the squashfs and erofs hooks, the TEE/fTPM integration, the
> +  file-marker factory reset (`factory-reset-helper-file`), and for crypt the
> +  clevis backend and `CRYPT_BTRFS_SUPPORT`.
> +- One generator per image. Isar's `initramfs.bbclass` rejects an image that
> +  mixes generators - with dracut selected, any package whose name contains
> +  `initramfs` is an error - so there is no hybrid migration step.
> +- qemu-amd64 only so far. Other machines follow in later increments.

Not sure if these temporary limitations need to go here. Before merging
things, those should be resolved first.

> diff --git a/doc/README.factory-reset.md b/doc/README.factory-reset.md
> index 4b1a1ab9..f1a0930e 100644
> --- a/doc/README.factory-reset.md
> +++ b/doc/README.factory-reset.md
> @@ -5,6 +5,8 @@ To enable the factory-reset functionality the following two elements need to be
>  ```
>  INITRAMFS_INSTALL += "initramfs-factory-reset-hook"
>  ```
> +  With dracut (`kas/opt/dracut.yml`), the module is `dracut-cip-factory-reset`
> +  instead. It is installed via `kas/opt/factory-reset.yml`, see [dracut](#dracut).
>  - factory-reset-helper which provides the helper scripts to set the factory-reset marker
>  ```
>  IMAGE_INSTALL += "factory-reset-helper"
> @@ -28,6 +30,50 @@ As the factory-reset is executed before the disks are unlocked in the initramfs,
>  variable `INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE`. The factory-reset of encrypted partition is not supported with the file based
>  marker.
>  
> +## dracut
> +
> +With `kas/opt/dracut.yml`, `dracut-cip-factory-reset` replaces
> +`initramfs-factory-reset-hook` and is installed automatically with
> +`kas/opt/factory-reset.yml`.
> +
> +- **Trigger:** only systemd's EFI variable
> +  `FactoryReset-8cf2644b-4b0b-428f-9387-6d876050dc67`. With dracut,
> +  `set-factory-reset.sh` writes this variable. EFI variables are required. A
> +  build with `factory-reset-helper-file` fails.
> +- **Flow:** a systemd generator pulls in `factory-reset.target` only if
> +  the variable exists. The variable is deleted before anything is wiped. A
> +  failing or timed-out reset (`INITRAMFS_FACTORY_RESET_TIMEOUT`) reboots
> +  (`FailureAction=reboot-force`) into a normal boot.
> +- **Plain partitions:** zeroed, `wipefs`, and re-created with the previous
> +  filesystem type and label.
> +- **Encrypted partitions** (`encrypt-partitions`): the LUKS keyslots are
> +  erased first (`cryptsetup erase`); the unlocked mapping keeps working
> +  because the kernel holds the volume key. Then the mapping is zeroed, so an
> +  interrupted reset cannot leave a partition that still unlocks with partly
> +  old data. Then the mapping is closed, the signature is removed, and on trixie the TPM is cleared (`tpm2_clear`,
> +  disable with `INITRAMFS_FACTORY_RESET_CLEAR_TPM = "0"`).
> +  `dracut-cip-crypt` then creates a new LUKS2 container with a new volume
> +  key and TPM2 token, and a new filesystem.
> +- **Filesystem type:** encrypted partitions get their filesystem from
> +  `dracut-cip-crypt` (`CRYPT_CREATE_FILE_SYSTEM_CMD`).
> +  `INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE` is only the fallback type for
> +  unencrypted devices without a detectable filesystem.
> +- **Unlock failed:** an encrypted partition that could not be unlocked is not
> +  zeroed. Its LUKS keyslots are erased and the TPM is cleared, so the data is
> +  unrecoverable (same as `initramfs-factory-reset-hook`).
> +- **All TPM2-sealed partitions:** clearing the TPM makes every TPM2-sealed
> +  partition impossible to unlock, including `CRYPT_PARTITIONS` entries not listed in
> +  `INITRAMFS_FACTORY_RESET_DEVICES`. List all of them.
> +- **Power loss:** a power loss during the reset (after the variable was
> +  deleted) leaves partially wiped partitions. The next boot does not repeat
> +  the reset.
> +- **Watchdog:** if `INITRAMFS_WATCHDOG_DEVICE` is set, the module configures
> +  systemd's hardware watchdog (`WatchdogDevice=`/`RuntimeWatchdogSec=`) for
> +  the initrd on every boot, not only during a reset.
> +- **Forky:** TPM clearing will move to `systemd-tpm2-clear.service`. Until
> +  then, `INITRAMFS_FACTORY_RESET_CLEAR_TPM` is ignored there, and the build
> +  shows a warning.

Why do we need to document all this only now? What makes it
dracut-specific? Looks strange.

> +
>  ## Verification
>  
>  - Create a test file in a target partition (ex: `/var`)
> diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
> index 658396a4..f576bc49 100644
> --- a/doc/README.secureboot.md
> +++ b/doc/README.secureboot.md
> @@ -179,6 +179,10 @@ local_conf_header:
>  Replace `demo` with the name of the user-generated certificates. The user-generated certificates
>  need to stored in the folder `recipes-devtools/secure-boot-secrets/files`.
>  
> +The example above builds the initramfs with initramfs-tools. The initrd can
> +alternatively be generated with dracut, which replaces `initramfs-verity-hook`
> +by the dracut module `cip-verity`, see [README.dracut.md](README.dracut.md).
> +
>  Build the image with user-generated keys by executing the command:
>  
>  ```bash

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
