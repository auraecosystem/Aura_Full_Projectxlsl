fetch("paperweb_live.json")
.then(resp => resp.json())
.then(data => {
    const treeContainer = document.getElementById("tree");
    const detailContainer = document.getElementById("detail-content");
    const breadcrumbContainer = document.getElementById("breadcrumbs");

    function createNode(name, children=null, parentExt=null, parentSheet=null, path=[]) {
        const li = document.createElement("li");
        const span = document.createElement("span");
        span.textContent = name;
        li.appendChild(span);

        span.onclick = (e) => {
            e.stopPropagation();
            let currentPath = [...path, name];
            breadcrumbContainer.innerHTML = "You are here: " + currentPath.join(" > ");

            detailContainer.innerHTML = `
                <h3>${name}</h3>
                <p><b>Extension:</b> ${parentExt || "-"}</p>
                <p><b>Sheet:</b> ${parentSheet || "-"}</p>
                <p><b>Purpose / Notes:</b> Describe purpose, signature, examples here.</p>
            `;
            li.classList.toggle("collapsed");
        };

        if(children && Object.keys(children).length > 0){
            const ul = document.createElement("ul");
            for(const childName in children){
                ul.appendChild(createNode(
                    childName,
                    children[childName] && Object.keys(children[childName]).length>0 ? children[childName] : null,
                    parentExt || name,
                    parentSheet || (parentExt ? name : null),
                    [...path, name]
                ));
            }
            li.appendChild(ul);
            li.classList.add("collapsed");
        }
        return li;
    }

    const ulRoot = document.createElement("ul");
    for(const ext in data.extensions){
        ulRoot.appendChild(createNode(ext, data.extensions[ext]));
    }
    treeContainer.appendChild(ulRoot);

    // Live search
    document.querySelector(".search").addEventListener("input", e => {
        const filter = e.target.value.toLowerCase();
        document.querySelectorAll("li span").forEach(span => {
            if(span.textContent.toLowerCase().includes(filter)){
                span.classList.add("highlight");
            } else {
                span.classList.remove("highlight");
            }
        });
    });
});
