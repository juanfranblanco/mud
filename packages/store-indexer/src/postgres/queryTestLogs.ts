import { PendingQuery, Sql } from "postgres";

import { Record } from "./common";

export function queryTestLogs(sql: Sql): PendingQuery<Record[]> {
  return sql`
		WITH config AS (
			SELECT
				version AS "indexerVersion",
				chain_id AS "chainId",
				block_number AS "chainBlockNumber"
			FROM
				"mud"."config"
			LIMIT 1
		),
		records AS (
			SELECT
				'0x' || encode(address,
					'hex') AS address,
				'0x' || encode(table_id,
					'hex') AS "tableId",
				'0x' || encode(key_bytes,
					'hex') AS "keyBytes",
				'0x' || encode(static_data,
					'hex') AS "staticData",
				'0x' || encode(encoded_lengths,
					'hex') AS "encodedLengths",
				'0x' || encode(dynamic_data,
					'hex') AS "dynamicData",
				block_number AS "recordBlockNumber",
				log_index AS "logIndex"
			FROM
				"mud"."records"
			WHERE (is_deleted != TRUE
				AND((address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x6f7400000000000000000000000000004d617463680000000000000000000000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x7462000000000000000000000000000043686172676572730000000000000000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746200000000000000000000000000004f776e65644279000000000000000000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x74620000000000000000000000000000506c6179657200000000000000000000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x74620000000000000000000000000000456e7469746965734174506f73697469')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x74620000000000000000000000000000537061776e5265736572766564427900')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746200000000000000000000000000004d61746368506c617965720000000000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746200000000000000000000000000004e616d65000000000000000000000000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x7462000000000000000000000000000041646d696e0000000000000000000000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746200000000000000000000000000004865726f496e526f746174696f6e0000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746200000000000000000000000000004865726f496e536561736f6e50617373')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x74620000000000000000000000000000536b79506f6f6c436f6e666967000000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746200000000000000000000000000004d617463685265776172645065726365')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746200000000000000000000000000004c6576656c496e5374616e6461726452')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746200000000000000000000000000004c6576656c496e536561736f6e506173')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746200000000000000000000000000004c6173744d61746368496e6465780000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746200000000000000000000000000004d61746368496e646578000000000000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746200000000000000000000000000004d61746368496e646578546f456e7469')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x74620000000000000000000000000000536561736f6e50617373496e64657800')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x74620000000000000000000000000000536561736f6e50617373436f6e666967')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x74620000000000000000000000000000536561736f6e506173734c6173745361')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746200000000000000000000000000004d61746368456e74697479436f756e74')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746200000000000000000000000000004d61746368537061776e506f696e7473')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746200000000000000000000000000004d61746368506c617965727300000000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746200000000000000000000000000004d61746368536b790000000000000000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746200000000000000000000000000004d61746368436f6e6669670000000000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746200000000000000000000000000004d61746368416363657373436f6e7472')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746200000000000000000000000000004d61746368416c6c6f77656400000000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746200000000000000000000000000004d6174636846696e6973686564000000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746200000000000000000000000000004d617463684d6170436f707950726f67')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746200000000000000000000000000004d617463685265616479000000000000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746200000000000000000000000000004d6174636852616e6b696e6700000000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746200000000000000000000000000004d6174636853776565707374616b6500')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746200000000000000000000000000004d617463685265776172640000000000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x7462000000000000000000000000000054656d706c6174655461626c65730000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x7462000000000000000000000000000054656d706c617465436f6e74656e7400')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746200000000000000000000000000004c6576656c54656d706c617465730000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746200000000000000000000000000004c6576656c54656d706c61746573496e')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746200000000000000000000000000004c6576656c506f736974696f6e000000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746200000000000000000000000000004c6576656c506f736974696f6e496e64')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746200000000000000000000000000005669727475616c4c6576656c54656d70')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746265726332302d707570706574000045524332305265676973747279000000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x74624f7262000000000000000000000042616c616e6365730000000000000000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x7462536561736f6e506173730000000042616c616e6365730000000000000000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x7462536b794b6579000000000000000042616c616e6365730000000000000000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746200000000000000000000000000005573657244656c65676174696f6e436f')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x7462000000000000000000000000000053797374656d626f756e6444656c6567')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746273746f726500000000000000000053746f7265486f6f6b73000000000000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746273746f72650000000000000000005461626c657300000000000000000000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746273746f72650000000000000000005265736f757263654964730000000000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746273746f7265000000000000000000486f6f6b730000000000000000000000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x7462776f726c640000000000000000004e616d6573706163654f776e65720000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x7462776f726c640000000000000000005265736f757263654163636573730000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x7462776f726c64000000000000000000496e7374616c6c65644d6f64756c6573')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x7462776f726c640000000000000000005573657244656c65676174696f6e436f')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x7462776f726c640000000000000000004e616d65737061636544656c65676174')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x7462776f726c6400000000000000000042616c616e6365730000000000000000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x7462776f726c6400000000000000000053797374656d73000000000000000000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x7462776f726c6400000000000000000053797374656d52656769737472790000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x7462776f726c6400000000000000000053797374656d486f6f6b730000000000')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x7462776f726c6400000000000000000046756e6374696f6e53656c6563746f72')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x6f74776f726c6400000000000000000046756e6374696f6e5369676e61747572')
				OR(address = '\x7203e7adfdf38519e1ff4f8da7dcdc969371f377'
					AND table_id = '\x746273746f72650000000000000000005461626c657300000000000000000000')))
		ORDER BY
			block_number,
			log_index ASC
		)
		SELECT
			(
				SELECT
					COUNT(*)
				FROM
					records) AS "totalRows",
			*
		FROM
			config,
			records;
		`;
}