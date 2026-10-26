# ROME Coverage Homework

Open `rome_submission.ipynb` in Google Colab to inspect the executed experiment. The original ROME utility, RTL-repair, hierarchy, and PPA functions are retained. The extension uses explicit bottom-up calls to the original `verilog_loop`, passing already generated dependencies.

## Evidence
- `mux_original/`: original six mux modules, fixed testbenches, raw responses and repair logs.
- `mux_ppa_runs/`: PPA optimization candidates, metrics, logs and summary.json.
- `adder/`: generated modules and baseline testbenches; `prompts/` stores generation prompts.
- `adder/coverage/{baseline,refine_1,refine_2}/`: simulation logs, VCD, CDD and reports. Refinement folders include LLM prompts and responses.
- `adder/coverage/coverage_history.json`: instance metrics used for comparison; original module metrics are retained separately when available.
- `adder/final/`: fixed final RTL and 31-test self-checking testbench.

## Reproduce final simulation
Requires Icarus Verilog. From HW_ROME_Coverage:

```sh
cd adder/final
iverilog -g2001 -s adder8tb -o final.vvp half_adder.v full_adder.v adder4.v adder8.v tb_final.v
vvp final.vvp
covered score -t adder8 -i adder8tb.dut -v half_adder.v -v full_adder.v -v adder4.v -v adder8.v -vcd adder8.vcd -o final.cdd
covered report -m ltc -d s -i -o final_summary.rpt final.cdd
covered report -m ltc -d v -i -o final_detail.rpt final.cdd
```

The recorded run used Icarus Verilog 12.0 and Covered 0.7.10. For newer Icarus VCD comments, apply the notebook's VCD cleanup before scoring. Archived CDD files and logs contain the original Colab paths; regenerate from RTL/VCD for a relocated checkout.

## Notebook execution
Use a fresh Colab runtime for a full rerun and enable access to the OpenAI secret named ROME. API calls incur usage and may generate different RTL/tests. Existing-file assertions protect baseline testbenches. Do not rerun generation into the archived evidence folders. Download cells save checkpoints; the notebook itself must also be saved/downloaded. Preserved outputs document the submitted experiment; cleanup was not followed by another paid API run.

## Submission cleanup
Removed the duplicate legacy API configuration (which would overwrite OpenAI settings) and duplicate mux download cell, retaining executed outputs elsewhere. Normalized coverage history to instance aggregation. RTL, testbenches, LLM responses, and original reports were not changed. The report was added after checking saved logs and RTL hashes. No local simulator rerun is claimed.
