import { promises as fs } from "fs";
import { loadPolicy } from "@open-policy-agent/opa-wasm";

(async function readPolicy() {
  const policyWasm = await fs.readFile("policy.wasm");
  const policy = await loadPolicy(policyWasm);
  const input = JSON.parse(process.argv[2]);
  // Provide a data document
  policy.setData({
    user_roles: {
      userA: ["editor"],
    },
    role_permissions: {
      editor: [
        { action: "edit", object: "article" },
        { action: "create", object: "article" }
      ],
    },
  });

  // Evaluate the policy and log the result
  const result = policy.evaluate(input);
  if (result == null) {
    console.error("evaluation error");
    return;
  }
  if (result.length == 0) {
    console.log("undefined");
    return;
  }
  console.log(JSON.stringify(result, null, 2));
})().catch((err) => {
  console.log("ERROR: ", err);
  process.exit(1);
});
